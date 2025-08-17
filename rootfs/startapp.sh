#!/bin/sh
export HOME=/config
export XCOMPOSEFILE=/config/.XCompose

# Prevent message about unsupported Qt theme.
unset QT_STYLE_OVERRIDE

exec /opt/filecentipede/fileu
# vim:ft=sh:ts=4:sw=4:et:sts=4
