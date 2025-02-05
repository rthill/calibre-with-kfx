FROM ghcr.io/linuxserver/calibre:latest

LABEL org.opencontainers.image.description "An image for running Calibre with KFX support to allow conversion of KFX files to other formats."

# Install prerequisites
RUN apt update && \
    apt install -y --no-install-recommends \
    # Calibre deps
    ca-certificates \
    curl \
    gnupg2 \
    xz-utils \
    # QTWebEngine deps
    libxdamage-dev libxrandr-dev libxtst6 \
    # for kindle support
    xvfb \
    libegl1 \
    libopengl0 \
    libxkbcommon-x11-0 \
    libxcomposite-dev \
    # calibre 7
    libxcb-cursor0 \
    && rm -rf /var/lib/apt/lists/*

# Install wine
ARG WINE_BRANCH="stable"
RUN dpkg --add-architecture i386 \
    && mkdir -pm755 /etc/apt/keyrings \
    && curl -o /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
    && curl -L -o /etc/apt/sources.list.d/winehq-bookworm.sources https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources \
    && apt update \
    && apt install -y --no-install-recommends winbind winehq-${WINE_BRANCH} \
    && rm -rf /var/lib/apt/lists/*

# Calibre plugins and Kindle support
# KFX Output 272407
# KFX Input 291290
ARG USERNAME=abc
USER abc
COPY --chown=$USERNAME:$USERNAME kp3.reg /home/$USERNAME/kp3.reg
RUN cd /home/$USERNAME/ && curl -s -O https://d2bzeorukaqrvt.cloudfront.net/KindlePreviewerInstaller.exe \
    && DISPLAY=:0 WINEARCH=win64 WINEDEBUG=-all wine KindlePreviewerInstaller.exe /S \
    && cat kp3.reg >> /home/$USERNAME/.wine/user.reg && rm *.exe && rm kp3.reg \
    && curl -s -O https://plugins.calibre-ebook.com/272407.zip \
    && calibre-customize -a 272407.zip \
    && curl -s -O https://plugins.calibre-ebook.com/291290.zip \
    && calibre-customize -a 291290.zip \
    && rm *.zip
