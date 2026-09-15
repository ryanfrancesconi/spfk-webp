// Copyright Ryan Francesconi. All Rights Reserved. Revision History at https://github.com/ryanfrancesconi/spfk-webp

import Foundation
import libwebp
import SPFKImage
import UniformTypeIdentifiers

/// Writes lossy WebP through libwebp, with the ICC profile, EXIF and XMP as chunks.
///
/// WebP holds 8 bits per channel, so a deeper image is reduced.
public struct WebPImageEncoder: ImageFileEncoder {
    public init() {}

    public var type: UTType { .webP }

    public var usesQuality: Bool { true }

    public var maxPixelSize: Int? { Int(WEBP_MAX_DIMENSION) }

    public func encode(_ input: ImageFileEncoderInput) throws -> Data {
        let pixels = try input.rgbaPixels(bitsPerComponent: 8)
        let bitstream = try Self.bitstream(pixels, quality: input.quality)

        return try Self.assemble(bitstream, chunks: [("ICCP", pixels.iccProfile), ("EXIF", input.exif), ("XMP ", input.xmp)])
    }

    static func bitstream(_ pixels: RGBAPixelBuffer, quality: Double) throws -> Data {
        var config = WebPConfig()
        var picture = WebPPicture()

        guard WebPConfigInit(&config) != 0, WebPPictureInit(&picture) != 0 else { throw failure }

        config.quality = Float(quality * 100)
        config.thread_level = 1

        picture.use_argb = 1
        picture.width = Int32(pixels.width)
        picture.height = Int32(pixels.height)

        defer { WebPPictureFree(&picture) }

        let imported = pixels.data.withUnsafeBytes { bytes in
            let samples = bytes.bindMemory(to: UInt8.self).baseAddress
            let stride = Int32(pixels.width * 4)

            return pixels.hasAlpha
                ? WebPPictureImportRGBA(&picture, samples, stride)
                : WebPPictureImportRGBX(&picture, samples, stride)
        }

        guard imported != 0 else { throw failure }

        var writer = WebPMemoryWriter()
        WebPMemoryWriterInit(&writer)

        defer { WebPMemoryWriterClear(&writer) }

        let encoded = withUnsafeMutablePointer(to: &writer) { writerPointer in
            picture.writer = WebPMemoryWrite
            picture.custom_ptr = UnsafeMutableRawPointer(writerPointer)

            return WebPEncode(&config, &picture)
        }

        guard encoded != 0, let memory = writer.mem else { throw failure }

        return Data(bytes: memory, count: writer.size)
    }

    /// The bitstream in a WebP container with each non-empty chunk, keyed by FourCC.
    static func assemble(_ bitstream: Data, chunks: [(fourCC: String, data: Data?)]) throws -> Data {
        guard let mux = WebPMuxNew() else { throw failure }

        defer { WebPMuxDelete(mux) }

        try set(bitstream) { WebPMuxSetImage(mux, &$0, 1) }

        for chunk in chunks {
            guard let data = chunk.data, !data.isEmpty else { continue }
            try set(data) { WebPMuxSetChunk(mux, chunk.fourCC, &$0, 1) }
        }

        var output = WebPData()

        guard WebPMuxAssemble(mux, &output) == WEBP_MUX_OK else { throw failure }

        defer { WebPDataClear(&output) }

        guard let bytes = output.bytes else { throw failure }

        return Data(bytes: bytes, count: output.size)
    }

    /// Hands `data` to a mux call that copies it.
    private static func set(_ data: Data, _ call: (inout WebPData) -> WebPMuxError) throws {
        let result = data.withUnsafeBytes { bytes in
            var webPData = WebPData(bytes: bytes.bindMemory(to: UInt8.self).baseAddress, size: bytes.count)
            return call(&webPData)
        }

        guard result == WEBP_MUX_OK else { throw failure }
    }

    private static var failure: ImageConversionError {
        .encodeFailed(UTType.webP.identifier)
    }
}
