# spfk-webp

[![Version](https://img.shields.io/github/v/tag/ryanfrancesconi/spfk-webp)](https://github.com/ryanfrancesconi/spfk-webp/tags)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fryanfrancesconi%2Fspfk-webp%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/ryanfrancesconi/spfk-webp)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fryanfrancesconi%2Fspfk-webp%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/ryanfrancesconi/spfk-webp)

WebP output for [spfk-image](https://github.com/ryanfrancesconi/spfk-image)'s `ImageFormatConverter`, which ImageIO
reads but cannot write: [libwebp](https://chromium.googlesource.com/webm/libwebp) vendored as source, and an encoder
over it.

> **The root `LICENSE` (MIT) covers this packaging only — not libwebp.** See
> [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md) for its terms and the attribution an embedding application owes.

## Features

- **`WebPImageEncoder`** — an `ImageFileEncoder` writing lossy WebP at the conversion's quality, with the ICC
  profile, EXIF and XMP as chunks. WebP holds 8 bits per channel and at most 16383 pixels on a side: a deeper image
  is reduced, and a larger one is refused before it renders.
- **`libwebp`** — the C library's decoder, encoder, mux and sharpyuv, for direct use.

## Usage

```swift
let formats = ImageConversionFormats(encoders: [WebPImageEncoder()])
let converted = try ImageFormatConverter(source: source, formats: formats).convert()
```

Pass the same `formats` to whatever offers the output types, so WebP is listed wherever it can be written.

## Updating libwebp

The vendored sources are an unmodified upstream release. They move to the newest upstream release near the end of each
TorchTag release cycle: release tags only, never `main`.

`scripts/vendor-libwebp.sh <checkout>` replaces `Sources/libwebp/` from a libwebp checkout at a release tag, keeping
only the headers the sources include, and records the tag in `upstream-versions.txt`.

1. Run the script against a checkout of the current tag first. `git status` must stay clean; anything it reports is a
   local change the update would erase.
2. Run it against the new tag, and re-read `COPYING` and `PATENTS`.
3. Run the package's tests and a WebP conversion in TorchTag before tagging.

## Dependencies

| Package | Description |
|---------|-------------|
| [spfk-image](https://github.com/ryanfrancesconi/spfk-image) | `ImageFileEncoder` and the converter it plugs into |
| [spfk-base](https://github.com/ryanfrancesconi/spfk-base) | Test support |

## Requirements

- **Platforms:** macOS 13+
- **Swift:** 6.2+

## About

Spongefork is the personal software projects of musician and developer [Ryan Francesconi](https://spongefork.com). Dedicated to creative sound manipulation, his first application, Spongefork, was released in 1999 for macOS 8. From 2026, Spongefork returns as his software container for more musical experimentation. In addition to [software releases](https://spongefork.com/shadowtag/), open source components can be found on his [GitHub page](https://github.com/ryanfrancesconi).
