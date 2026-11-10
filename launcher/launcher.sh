#!/bin/bash
# 由 MOSS-Image-Cai.app 调用：确保 7860 工作台服务在线
set -u
LOG=/Users/johnsmacbook/MOSS-Image/logs/launcher.log
PLIST=/Users/johnsmacbook/Library/LaunchAgents/com.moss.image.workbench.plist
UID_N=$(id -u)
mkdir -p "$(dirname "$LOG")"
echo "[$(date '+%F %T')] launcher start (uid=$UID_N)" >>"$LOG"

if curl -s -o /dev/null -m 2 http://127.0.0.1:7860/; then
  echo "[$(date '+%F %T')] service already up" >>"$LOG"
  exit 0
fi

launchctl bootstrap "gui/$UID_N" "$PLIST" >>"$LOG" 2>&1 || true
launchctl kickstart -k "gui/$UID_N/com.moss.image.workbench" >>"$LOG" 2>&1 || true

for _ in $(seq 1 90); do
  if curl -s -o /dev/null -m 2 http://127.0.0.1:7860/; then
    echo "[$(date '+%F %T')] service ready" >>"$LOG"
    exit 0
  fi
  sleep 1
done
echo "[$(date '+%F %T')] service NOT ready after 90s" >>"$LOG"
exit 1
