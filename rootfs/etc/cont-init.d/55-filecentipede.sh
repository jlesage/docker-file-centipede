#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

# Make sure needed directories are created.
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p /config/cache
mkdir -p /run/user && chmod a+rw /run/user

# Install default configuration.
for f in data_linux.db fileu_linux.conf; do
    [ -f /config/"$f" ] || cp -v /defaults/"$f" /config/
done
[ -f "$XDG_CONFIG_HOME"/QtProject.conf ] || cp -v /defaults/QtProject.conf "$XDG_CONFIG_HOME"/

# Handle dark mode change.
rm -rf /tmp/theme
if is-bool-val-false "${DARK_MODE:-0}"; then
    cp -a /opt/filecentipede/themes/light /tmp/theme
else
    cp -a /opt/filecentipede/themes/dark /tmp/theme
fi

# Take ownership of the output directory.
take-ownership --not-recursive --skip-if-writable /output

# vim:ft=sh:ts=4:sw=4:et:sts=4
