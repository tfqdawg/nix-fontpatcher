#!/usr/bin/env bash
set -euo pipefail

IN_DIR="${1:-./fonts}"
OUT_DIR="${2:-./patched}"
shift $(( $# > 2 ? 2 : $# ))

if [ ! -d "$IN_DIR" ]; then
  echo "Input directory '$IN_DIR' not found." >&2
  exit 1
fi

mkdir -p "$OUT_DIR"

count=0
while IFS= read -r -d '' font; do
  echo ">> PATCHING: $font"
  nerd-font-patcher --complete --outputdir "$OUT_DIR" "$@" "$font"
  count=$((count + 1))
done < <(find "$IN_DIR" -type f \( -iname '*.ttf' -o -iname '*.otf' \) -print0)

echo "PATCHED $count FONT(S) INTO $OUT_DIR"
