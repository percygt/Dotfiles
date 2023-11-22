#! /bin/bash

# set -eu
# set -o pipefail

#Update flatpak
/usr/bin/flatpak update -y


#Update flatpak local repo
[ -d /data/flatpak-repo ] && flatpak create-usb /data/flatpak-repo $(flatpak list --all --columns=ref,origin | grep flathub | cut -d$'\t' -f1 | grep Locale) --allow-partial
