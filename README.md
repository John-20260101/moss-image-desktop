# MOSS-Image Desktop

> 下载地址：[Releases · v0.1.0](https://github.com/John-20260101/moss-image-desktop/releases/tag/v0.1.0)

把本地 **MOSS-Image 工作台**（Gradio 网页 `127.0.0.1:7860`）封装成 macOS 桌面 App 的 Pake / Tauri 外壳。
图标是扁平矢量狸花猫（蜷缩环猫），窗口 1280×860，Apple Silicon（arm64）。

> 这是“窗口外壳”，**不含模型与推理环境**。生成能力来自本机已部署的 MOSS-Image（MLX）服务；
> 服务未启动时 App 会白屏，请先用启动脚本或 `start.sh` 拉起服务。

## 下载安装

1. 到 Releases 下载 `MOSS-Image_0.1.0_aarch64.dmg`；
2. 双击挂载，把 `MOSS-Image.app` 拖进「应用程序」；
3. 未做 Apple 公证，首次打开被 Gatekeeper 拦截时：右键 → 打开，或
   `xattr -dr com.apple.quarantine /Applications/MOSS-Image.app`。

## 前置条件

- macOS（Apple Silicon）
- 本机已部署 MOSS-Image 工作台：`~/Desktop/ppt-sum/.moss/`（含模型与 `ui/app.py`）
- 启动服务：`~/Desktop/ppt-sum/.moss/ui/start.sh`（监听 `127.0.0.1:7860`）

## 从源码构建

依赖：Node.js ≥ 18、Rust 工具链（`rustup` 或 Homebrew `rust`）、macOS 命令行工具。

```bash
npm install
./scripts/build.sh 0.1.0
# 产物：dist/MOSS-Image_0.1.0_aarch64.dmg
```

构建细节：`pake-cli 3.18.0`（Tauri 2，target `aarch64-apple-darwin`）；
若 Tauri 的 `bundle_dmg.sh` 失败，脚本会自动回退到 `hdiutil` 手动打包。

## 目录

```
.
├── icon.icns                # App 图标（狸花猫 B 版）
├── assets/                  # 图标源图
├── scripts/build.sh         # 一键构建 App + DMG
├── docs/使用说明.md          # 安装/启动/界面/FAQ
└── package.json
```

## 说明与限制

- App 只是 WebView 窗口，URL 固定为 `http://127.0.0.1:7860`；不随包分发模型。
- 仅 ad-hoc 签名，未公证；分发给他人的机器会被 Gatekeeper 拦（需右键打开）。
- 图标为 AI 生成概念稿，正式品牌使用前建议矢量化。
- 依赖上游项目：Pake（Tauri）、MOSS-Image（OpenMOSS）与 MLX 移植版；本仓库只包含封装配置与素材。

## 许可

本仓库代码（构建脚本/配置）采用 MIT；上游 Pake、MOSS-Image 及其权重遵循各自许可证。
