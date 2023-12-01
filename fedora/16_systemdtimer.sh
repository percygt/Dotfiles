#!/bin/bash
set -eu

[ "$UID" -ne 0 ] || { echo "This script must be run by $SUDO_USER."; exit 1;}

cp -rv /data/dotfiles/scripts/. /home/percygt/.local/bin/

sudo cp -rv /data/dotfiles/systemd/. /etc/systemd/system/