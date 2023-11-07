#!/bin/bash
set -eu

[ "$UID" -eq 0 ] || { echo "This script must be run as root."; exit 1;}


dnf install kernel-devel -y
dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda -y

