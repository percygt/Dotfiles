#!/bin/bash
set -eu

[ "$UID" -ne 0 ] || { echo "This script must be run by $SUDO_USER."; exit 1;}

stow -d stow/ -t $HOME

echo -e "\033[0;33mMOVE PERMANENT DATA to /data"

