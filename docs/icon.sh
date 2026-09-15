#!/bin/bash
# Regenerates Resources/dwell.icns and docs/icon.png from docs/icon.swift — the app icon as
# trydwell.app draws it. Run if the site's icon changes.
set -euo pipefail
cd "$(dirname "$0")/.."
WORK="${TMPDIR:-/tmp}/dwell-icon"
rm -rf "$WORK" && mkdir -p "$WORK/dwell.iconset"
swift docs/icon.swift "$WORK/dwell.png"
for spec in 16:16 32:16@2x 32:32 64:32@2x 128:128 256:128@2x 256:256 512:256@2x 512:512 1024:512@2x; do
  px=${spec%%:*}; name=${spec##*:}
  sips -z "$px" "$px" "$WORK/dwell.png" --out "$WORK/dwell.iconset/icon_${name}.png" >/dev/null
done
iconutil -c icns "$WORK/dwell.iconset" -o Resources/dwell.icns
cp "$WORK/dwell.png" docs/icon.png
echo "Resources/dwell.icns and docs/icon.png regenerated"
