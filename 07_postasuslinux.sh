#!/bin/bash
set -eu

[ "$UID" -eq 0 ] || { echo "This script must be run as root."; exit 1;} # Need to figure out how to pkexec so we only ask for the password once.

dnf install asusctl supergfxctl -y
dnf update --refresh -y
systemctl enable supergfxd.service

systemctl reboot