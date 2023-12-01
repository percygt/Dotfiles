#!/bin/bash
set -eu

[ "$UID" -eq 0 ] || { echo "This script must be run as root."; exit 1;}

dnf install asusctl supergfxctl -y
dnf update --refresh -y
systemctl enable supergfxd.service

systemctl reboot