# MOSS-Image-Cai Desktop

把本地 **MOSS-Image 工作台**（Gradio `127.0.0.1:7860`）封装成 macOS 桌面 App。
应用名 **MOSS-Image-Cai**，图标为扁平矢量狸花猫（B 版），Apple Silicon（arm64）。

> 这是个“**双击即启动服务 + 打开窗口**”的一体化壳：外层 AppleScript 负责确保服务在线，
> 内层是 Pake/Tauri WebView。**模型与推理环境不在本仓库**，需要本机已部署 MOSS-Image（MLX）。

- 下载：[Releases · v0.1.1](https://github.com/John-20260101/moss-image-desktop/releases/tag/v0.1.1)
- 图标预览：[assets/cat-icon-b.png](assets/cat-icon-b.png)

## 结构

```
MOSS-Image-Cai.app                  # 外层 AppleScript 启动壳（双击入口）
└── Contents/Resources/MOSS-Image-Cai Web.app   # 内层 Pake/Tauri 窗口
```

打开时壳会：
1. 检查 `127.0.0.1:7860` 是否在线；
2. 不在线则 `launchctl bootstrap/kickstart` 启动 LaunchAgent；
3. 服务就绪后打开内层窗口（通常 10–15 秒）。

## 安装

1. 下载 `MOSS-Image-Cai_0.1.1_aarch64.dmg`；
2. 把 `MOSS-Image-Cai.app` 拖进「应用程序」；
3. 未公证：首次右键 → 打开，或
   `xattr -dr com.apple.quarantine /Applications/MOSS-Image-Cai.app`。

## 前置条件

- macOS（Apple Silicon）
- 本机部署：`~/MOSS-Image/.moss/`（含模型、venv、`ui/app.py`）
- 开机自启服务（推荐）：安装 `launchagent/com.moss.image.workbench.plist` 到
  `~/Library/LaunchAgents/` 后执行
  `launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.moss.image.workbench.plist`

> 运行环境必须放在**非受保护目录**（如 `~/MOSS-Image`）。放桌面/文稿下，launchd 会因隐私保护
> 报 `Operation not permitted`，App 就无法自动拉起服务。

## 从源码构建

依赖：Node.js ≥ 18、Rust 工具链、macOS 命令行工具、AppleScript 编译器（系统自带）。

```bash
# 1) 内层 Pake WebView
npm install
./scripts/build.sh 0.1.1          # 产出内层 .app 与 DMG

# 2) 外层启动壳（把内层 app 嵌入 Resources 并重签）
./scripts/build-shell.sh 0.1.1    # 产出 MOSS-Image-Cai_0.1.1_aarch64.dmg
```

`launcher/launcher.applescript` 是壳脚本（调用 `launcher/launcher.sh` 确保服务在线）；
`launchagent/` 是开机自启配置。

## 目录

```
.
├── launcher/               # AppleScript 壳 + 服务启动脚本
├── launchagent/            # LaunchAgent plist（登录自启服务）
├── scripts/                # 构建脚本（内层 / 外壳）
├── docs/使用说明.md         # 安装、使用、FAQ、卸载
├── assets/                 # 图标素材
├── icon.icns
└── package.json
```

## 说明与限制

- 内层窗口 URL 固定 `http://127.0.0.1:7860`；不含模型，不随包分发推理环境。
- 仅 ad-hoc 签名、未公证；分发给他人需右键打开。
- 图标为 AI 生成概念稿，正式品牌使用前建议矢量化。
- 依赖上游：Pake（Tauri）、MOSS-Image（OpenMOSS）与 MLX 移植版。

## 许可

本仓库脚本与配置采用 MIT；上游 Pake、MOSS-Image 及权重遵循各自许可证。
