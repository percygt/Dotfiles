#!/bin/bash
set -eu

[ "$UID" -ne 0 ] || { echo "This script must be run by $SUDO_USER."; exit 1;}

CONFIG_DIR="$HOME/.config"

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

rsync -v --ignore-existing "/data/dotfiles/home-manager/" "$CONFIG_DIR/home-manager/"

nix run home-manager/release-23.11 -- init --switch