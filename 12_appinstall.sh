#!/bin/bash
set -eu

[ "$UID" -ne 0 ] || { echo "This script must be run by $SUDO_USER."; exit 1;}

#rpm apps install
sudo xargs dnf install -y < ./files/dnf_apps.txt
sudo flatpak remote-modify --collection-id=org.flathub.Stable flathub;

#Flatpaks offline install
[ -d /data/flatpak-repo ] && xargs flatpak install -y --sideload-repo=/data/flatpak-repo/.ostree/repo/ < ./files/flatpaks-offline.txt

#Flatpaks online install
xargs flatpak install -y < ./files/flatpaks.txt