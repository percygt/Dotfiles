#!/bin/bash
set -eu

[ "$UID" -ne 0 ] || { echo "This script must be run by $SUDO_USER."; exit 1;}

# cd stow
stow -t $HOME .stow/*

echo -e "\033[0;33mMOVE PERMANENT DATA to /data"

