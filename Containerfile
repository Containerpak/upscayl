FROM ubuntu:26.04 AS source

RUN apt-get update && \
    apt-get install -y --no-install-recommends unzip

ADD --checksum=sha256:3a43bfa80ba10a5ec1dcbbec9e6620b465f6aa541b7280b6bbabf8e306b67053 https://github.com/upscayl/upscayl/releases/download/v2.15.0/upscayl-2.15.0-linux.zip /tmp/app.zip

RUN mkdir -p /stage && \
    unzip -q /tmp/app.zip -d /stage

FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/upscayl"

COPY --from=source /stage/ /opt/upscayl/
COPY upscayl /usr/bin/upscayl
COPY upscayl.desktop /usr/share/applications/upscayl.desktop
COPY icon.png /usr/share/icons/hicolor/128x128/apps/upscayl.png

RUN chmod 0755 /usr/bin/upscayl && cpak-clean-junk
