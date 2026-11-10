#!/usr/bin/env bash
# 构建 MOSS-Image 桌面 App 与 DMG（macOS / Apple Silicon）
set -euo pipefail

VERSION="${1:-0.1.0}"
NAME="MOSS-Image"
BUNDLE_ID="com.moss.image"
URL="http://127.0.0.1:7860"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "==> 安装依赖"
npm install --no-audit --no-fund

echo "==> Pake 构建 v${VERSION}"
npx pake "$URL" \
  --name "$NAME" --identifier "$BUNDLE_ID" \
  --icon icon.icns --width 1280 --height 860 \
  --title "${NAME} 工作台" --app-version "$VERSION" --targets dmg || true

APP="node_modules/pake-cli/src-tauri/target/aarch64-apple-darwin/release/bundle/macos/${NAME}.app"
DMG="node_modules/pake-cli/src-tauri/target/aarch64-apple-darwin/release/bundle/dmg/${NAME}_${VERSION}_aarch64.dmg"
OUT="dist/${NAME}_${VERSION}_aarch64.dmg"
mkdir -p dist

if [ -f "$DMG" ]; then
  cp "$DMG" "$OUT"
else
  echo "==> bundler 未产出 DMG，改用 hdiutil 手动打包"
  [ -d "$APP" ] || { echo "缺少 ${APP}"; exit 1; }
  rm -rf dmg-staging && mkdir -p dmg-staging
  cp -R "$APP" dmg-staging/
  ln -s /Applications dmg-staging/Applications
  hdiutil create -volname "$NAME" -srcfolder dmg-staging -ov -format UDZO -fs HFS+ "$OUT"
fi

echo "==> 完成：$OUT"
hdiutil verify "$OUT"
