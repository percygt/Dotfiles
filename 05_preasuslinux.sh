#!/bin/bash
set -eu

[ "$UID" -eq 0 ] || { echo "This script must be run as root."; exit 1;} # Need to figure out how to pkexec so we only ask for the password once.


dnf install kernel-devel -y
dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda -y

