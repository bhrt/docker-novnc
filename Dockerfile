FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8

RUN set -ex; \
    apt-get update; \
    apt-get install -y \
    bash \
    fluxbox \
    git \
    net-tools \
    novnc \
    supervisor \
    x11vnc \
    xterm \
    curl \
    xvfb && \
    rm -rf /var/lib/apt/lists/*

ENV HOME=/root \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1920 \
    DISPLAY_HEIGHT=1200 \
    X11VNC_IDLE_TIMEOUT=1200 \
    RUN_XTERM=yes \
    RUN_FLUXBOX=yes

COPY . /app
WORKDIR /app

CMD ["/app/entrypoint.sh"]
EXPOSE 8080
