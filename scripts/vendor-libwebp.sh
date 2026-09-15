#!/bin/sh
# Copies libwebp's decoder, encoder, mux and sharpyuv sources from a checkout into Sources/libwebp, with only the
# headers they include and the public headers, and its license files into Licenses/.
#
# Usage: scripts/vendor-libwebp.sh <libwebp checkout at a release tag>

set -eu

SRC="$(cd "$1" && pwd)"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$ROOT/Sources/libwebp"
LIST="$(mktemp)"

rm -rf "$DEST"
mkdir -p "$DEST" "$ROOT/Licenses"
cd "$SRC"

ls src/dec/*.c src/dsp/*.c src/enc/*.c src/utils/*.c src/mux/*.c sharpyuv/*.c > "$LIST"

{
    cat "$LIST"
    xargs -n 16 xcrun clang -MM -I. < "$LIST" | tr ' \\' '\n\n' | grep '\.h$' | sed 's#^\./##'
    ls src/webp/*.h
} | sort -u | while read -r file; do
    mkdir -p "$DEST/$(dirname "$file")"
    cp "$file" "$DEST/$file"
done

cp COPYING "$ROOT/Licenses/libwebp-COPYING.txt"
cp PATENTS "$ROOT/Licenses/libwebp-PATENTS.txt"
echo "libwebp $(git describe --tags)" > "$ROOT/upstream-versions.txt"

rm "$LIST"
echo "$(find "$DEST" -name '*.c' | wc -l) sources, $(find "$DEST" -name '*.h' | wc -l) headers: $(cat "$ROOT/upstream-versions.txt")"
