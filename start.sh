#!/bin/bash

mkdir -p /workspace

if [ ! -f /root/.vnc/passwd ]; then
    x11vnc -storepasswd "${VNC_PASSWORD:-ChangeMe123!}" /root/.vnc/passwd
fi

Xvfb :0 -screen 0 1920x1080x24 &
export DISPLAY=:0

fluxbox &

x11vnc \
    -display :0 \
    -forever \
    -shared \
    -rfbauth /root/.vnc/passwd \
    -listen 0.0.0.0 &

godot --editor /workspace &

exec /usr/share/novnc/utils/novnc_proxy \
    --listen 6080 \
    --vnc localhost:5900
