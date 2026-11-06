# spfk-webp

[![Version](https://img.shields.io/github/v/tag/ryanfrancesconi/spfk-webp)](https://github.com/ryanfrancesconi/spfk-webp/tags)
[![Swift](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fryanfrancesconi%2Fspfk-webp%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/ryanfrancesconi/spfk-webp)
[![Platforms](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fryanfrancesconi%2Fspfk-webp%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/ryanfrancesconi/spfk-webp)

WebP output for [spfk-image](https://github.com/ryanfrancesconi/spfk-image)'s image converter.
ImageIO reads WebP but cannot write it, so this package vendors
[libwebp](https://chromium.googlesource.com/webm/libwebp) as source and provides `WebPImageEncoder`.
The C library is also available directly as the `libwebp` product.

## Features

- Encodes at 8 bits per channel; deeper images are reduced
- Reports libwebp's maximum size per side to the converter (`maxPixelSize`)
- The vendored libwebp is an unmodified upstream release

## License

The root `LICENSE` (MIT) covers this packaging only, not libwebp. See
[THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md) for libwebp's terms and the attribution an
application that embeds it owes.

## About

Spongefork is the personal software projects of musician and developer [Ryan Francesconi](https://spongefork.com). Dedicated to creative sound manipulation, his first application, Spongefork, was released in 1999 for macOS 8. From 2026, Spongefork returns as his software container for more musical experimentation. In addition to [software releases](https://spongefork.com/shadowtag/), open source components can be found on his [GitHub page](https://github.com/ryanfrancesconi).
