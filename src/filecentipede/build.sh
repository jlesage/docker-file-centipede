#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

FC_ROOTFS=/tmp/filecentipede-rootfs
FC_INSTALL_DIR=/opt/filecentipede

function log {
    echo ">>> $*"
}

FILECENTIPEDE_URL="$1"

if [ -z "$FILECENTIPEDE_URL" ]; then
    log "ERROR: File centipede URL missing."
    exit 1
fi

log "Installing build prerequisites..."
apk --no-cache add \
    curl \

log "Downloading File centipede..."
curl -# -L -f -o /tmp/filecentipede.zip ${FILECENTIPEDE_URL}

log "Installing File centipede..."

mkdir -p "$FC_ROOTFS"/"$FC_INSTALL_DIR"
unzip -d "$FC_ROOTFS"/"$FC_INSTALL_DIR" /tmp/filecentipede.zip

# Config file and database should be saved outside the container.
for f in data_linux.db data_linux.db-shm data_linux.db-wal fileu_linux.conf; do
    ln -sv /config/"$f" "$FC_ROOTFS"/"$FC_INSTALL_DIR"/lib/"$f"
done
# Cache folder should be outside the container.
ln -sv /config/cache "$FC_ROOTFS"/"$FC_INSTALL_DIR"/cache

# Dark mode support. Icons and CSS files taken from https://github.com/filecxx/FileCentipede/issues/813.
# Replace all files by symlinks so we can use the correct version as runtime.
mkdir -p "$FC_ROOTFS"/"$FC_INSTALL_DIR"/themes/light
mkdir -p "$FC_ROOTFS"/"$FC_INSTALL_DIR"/themes/dark
unzip -d /tmp "$SCRIPT_DIR"/dark_mode.zip
find /tmp/dark_mode -type f | while read -r f; do
    fpath="$(echo "$f" | sed 's|^/tmp/dark_mode/||')"
    dir="$(dirname "$fpath")"

    mkdir -p "$FC_ROOTFS"/"$FC_INSTALL_DIR"/themes/light/"$dir"
    mkdir -p "$FC_ROOTFS"/"$FC_INSTALL_DIR"/themes/dark/"$dir"

    # Copy the light (original) version of the file.
    if [ -f "$FC_ROOTFS"/"$FC_INSTALL_DIR"/"$fpath" ]; then
        cp -v "$FC_ROOTFS"/"$FC_INSTALL_DIR"/"$fpath" "$FC_ROOTFS"/"$FC_INSTALL_DIR"/themes/light/"$dir"/
    fi

    # Copy the dark version of the file.
    cp -v /tmp/dark_mode/"$fpath" "$FC_ROOTFS"/"$FC_INSTALL_DIR"/themes/dark/"$dir"/

    # Replace the light (original) version of the file by a symlink.
    ln -sf /tmp/theme/"$fpath" "$FC_ROOTFS"/"$FC_INSTALL_DIR"/"$fpath"
done

# vim:ft=sh:ts=4:sw=4:et:sts=4
