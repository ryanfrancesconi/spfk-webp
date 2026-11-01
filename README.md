# spfk-webp

[![Version](https://img.shields.io/github/v/tag/ryanfrancesconi/spfk-webp)](https://github.com/ryanfrancesconi/spfk-webp/tags)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fryanfrancesconi%2Fspfk-webp%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/ryanfrancesconi/spfk-webp)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fryanfrancesconi%2Fspfk-webp%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/ryanfrancesconi/spfk-webp)

WebP output for [spfk-image](https://github.com/ryanfrancesconi/spfk-image)'s image converter.
ImageIO reads WebP but cannot write it, so this package vendors
[libwebp](https://chromium.googlesource.com/webm/libwebp) as source and supplies
`WebPImageEncoder`, an encoder the converter accepts for that type. The C library is also available
directly.

WebP holds 8 bits per channel and has a maximum pixel size per side, so a deeper image is reduced
and a larger one is refused before it renders.

> **The root `LICENSE` (MIT) covers this packaging only — not libwebp.** See
> [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md) for its terms and the attribution an embedding application owes.

## Upstream

The vendored sources are an unmodified upstream release. `scripts/vendor-libwebp.sh` replaces them
from a release-tag checkout and records the tag in `upstream-versions.txt`.

## About

Spongefork is the personal software projects of musician and developer [Ryan Francesconi](https://spongefork.com). Dedicated to creative sound manipulation, his first application, Spongefork, was released in 1999 for macOS 8. From 2026, Spongefork returns as his software container for more musical experimentation. In addition to [software releases](https://spongefork.com/shadowtag/), open source components can be found on his [GitHub page](https://github.com/ryanfrancesconi).
