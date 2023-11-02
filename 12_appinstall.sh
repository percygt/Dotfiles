#!/bin/bash
set -eu

[ "$UID" -ne 0 ] || { echo "This script must be run by $SUDO_USER."; exit 1;}

sudo xargs dnf install -y < ./files/dnf_apps.txt

xargs flatpak install -y < ./files/flatpaks.txt