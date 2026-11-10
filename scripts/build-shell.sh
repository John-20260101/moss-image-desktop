#!/usr/bin/env bash
# 把内层 Pake app 嵌进 AppleScript 启动壳，并打出最终 DMG
set -euo pipefail
VERSION="${1:-0.1.1}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
INNER="${INNER_APP:-/tmp/MOSS-Image-Cai-Web.app}"   # 内层解包路径，可用 INNER_APP 指定

[ -d "$INNER" ] || { echo "缺少内层 app: $INNER"; exit 1; }

rm -rf MOSS-Image-Cai.app
osacompile -o MOSS-Image-Cai.app launcher/launcher.applescript
mkdir -p MOSS-Image-Cai.app/Contents/Resources
cp -R "$INNER" "MOSS-Image-Cai.app/Contents/Resources/MOSS-Image-Cai Web.app"
cp icon.icns MOSS-Image-Cai.app/Contents/Resources/applet.icns

P=MOSS-Image-Cai.app/Contents/Info.plist
plutil -insert CFBundleIdentifier -string com.moss.image.launcher "$P" 2>/dev/null || true
plutil -insert CFBundleDisplayName -string MOSS-Image-Cai "$P" 2>/dev/null || true
plutil -insert CFBundleShortVersionString -string "$VERSION" "$P" 2>/dev/null || true

codesign --force --deep -s - MOSS-Image-Cai.app

rm -rf dmg-staging && mkdir -p dmg-staging
cp -R MOSS-Image-Cai.app dmg-staging/
ln -s /Applications dmg-staging/Applications
OUT="MOSS-Image-Cai_${VERSION}_aarch64.dmg"
hdiutil create -volname MOSS-Image-Cai -srcfolder dmg-staging -ov -format UDZO -fs HFS+ "$OUT"
hdiutil verify "$OUT"
echo "OK: $OUT"
