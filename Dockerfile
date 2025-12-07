#
# file-centipede Dockerfile
#
# https://github.com/jlesage/docker-file-centipede
#

# Docker image version is provided via build arg.
ARG DOCKER_IMAGE_VERSION=

# Define software versions.
ARG FILECENTIPEDE_VERSION=2.82

# Define software download URLs.
ARG FILECENTIPEDE_URL=http://filecxx.com/release/filecxx_${FILECENTIPEDE_VERSION}_linux_x64.zip

# Build File Centipede.
FROM alpine:3.21 AS filecentipede
ARG FILECENTIPEDE_URL
COPY src/filecentipede /build
RUN /build/build.sh "$FILECENTIPEDE_URL"

# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.21-v4.10.3

ARG FILECENTIPEDE_VERSION
ARG DOCKER_IMAGE_VERSION

# Define working directory.
WORKDIR /tmp

# Install extra packages.
RUN \
    add-pkg \
        ffmpeg \
        ffplay \
        pcmanfm \
        # Need a font.
        ttf-dejavu \
        && \
    # Prevent message: Fontconfig warning: "/usr/share/fontconfig/conf.avail/05-reset-dirs-sample.conf", line 6: unknown element "reset-dirs"
    rm /usr/share/fontconfig/conf.avail/05-reset-dirs-sample.conf

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://github.com/jlesage/docker-templates/raw/master/jlesage/images/file-centipede-icon.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Add files.
COPY rootfs/ /
COPY --from=filecentipede /tmp/filecentipede-rootfs /

# Set internal environment variables.
RUN \
    set-cont-env APP_NAME "File Centipede" && \
    set-cont-env APP_VERSION "$FILECENTIPEDE_VERSION" && \
    set-cont-env DOCKER_IMAGE_VERSION "$DOCKER_IMAGE_VERSION" && \
    true

# Define mountable directories.
VOLUME ["/storage"]
VOLUME ["/output"]

# Expose ports.
#   - 10111/tcp: File Centipede service for web browser extension.
#   - 17844/tcp: BitTorrent incoming port for peer connections.
#   - 17844/udp: BitTorrent incoming port for DHT functionality.
EXPOSE 10111/tcp
EXPOSE 17654/tcp
EXPOSE 17654/udp

# Metadata.
LABEL \
      org.label-schema.name="file-centipede" \
      org.label-schema.description="Docker container for File Centipede" \
      org.label-schema.version="${DOCKER_IMAGE_VERSION:-unknown}" \
      org.label-schema.vcs-url="https://github.com/jlesage/docker-file-centipede" \
      org.label-schema.schema-version="1.0"
