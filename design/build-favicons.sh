#!/bin/sh
# Renders the PNG icons from public/favicon.svg (needs ImageMagick).
# Browsers that use the SVG get its dark-mode variant; PNGs can't adapt, so they get a thin
# cream outline around the gate to stay visible on dark tabs.
set -e
cd "$(dirname "$0")/.."
tmp=$(mktemp --suffix=.svg)
sed 's|    .gate { fill: #221d2b; }|    .gate { fill: #221d2b; stroke: #f6f2e9; stroke-width: 3; paint-order: stroke; stroke-linejoin: round; }|' \
  public/favicon.svg > "$tmp"
grep -q paint-order "$tmp" || { echo "favicon.svg changed: update the .gate rule this script patches" >&2; exit 1; }
for s in 32 192; do
  convert -background none -density 1200 "$tmp" -resize ${s}x$s public/favicon-$s.png
done
# The home-screen icon must be opaque: the gate on cream.
convert -background '#f6f2e9' -density 1200 public/favicon.svg -resize 144x144 -gravity center -extent 180x180 -flatten public/apple-touch-icon.png
rm "$tmp"
echo "✓ favicon-32.png, favicon-192.png, apple-touch-icon.png"
