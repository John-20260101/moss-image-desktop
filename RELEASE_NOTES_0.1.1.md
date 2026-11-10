## v0.1.1 — MOSS-Image-Cai

- 应用改名：**MOSS-Image-Cai**（图标仍为狸花猫 B 版）
- 一体化启动壳：**双击 App 自动确保 7860 工作台服务在线**，再打开窗口（冷启动约 12 秒）
- 新增 LaunchAgent `com.moss.image.workbench`：登录自启、崩溃自动拉起
- 运行环境迁至 `~/MOSS-Image`（桌面留软链），避免 launchd 被隐私保护拦截
- 安装包：`MOSS-Image-Cai_0.1.1_aarch64.dmg`（拖入 Applications 即装）

### 使用前提
需本机已部署 MOSS-Image 工作台（`~/MOSS-Image/.moss/`）；App 不含模型。
