## v0.1.0 — 首个桌面版

- 用 Pake（Tauri 2）把 MOSS-Image 本地工作台封装成 macOS App
- 新图标：彩色狸花猫（蜷缩环猫，扁平矢量，无文字）
- Apple Silicon（arm64），窗口 1280×860
- 附 DMG（拖入 Applications 即装）；未公证，首次打开需右键 → 打开

### 使用前提
App 是外壳，需要本机先启动 MOSS-Image 工作台服务（`127.0.0.1:7860`）：
```bash
~/Desktop/ppt-sum/.moss/ui/start.sh
```
