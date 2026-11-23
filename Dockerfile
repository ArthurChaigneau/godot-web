FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV GODOT_VERSION=4.4

RUN apt-get update && apt-get install -y \
    xterm \
    x11-apps \
    wget \
    unzip \
    xvfb \
    x11vnc \
    fluxbox \
    novnc \
    websockify \
    ca-certificates

RUN wget -O /tmp/godot.zip \
    https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip \
    && unzip /tmp/godot.zip -d /opt/godot \
    && chmod +x /opt/godot/Godot_v${GODOT_VERSION}-stable_linux.x86_64 \
    && ln -s /opt/godot/Godot_v${GODOT_VERSION}-stable_linux.x86_64 /usr/local/bin/godot

COPY start.sh /start.sh

RUN chmod +x /start.sh

EXPOSE 6080

CMD ["/start.sh"]
