#!/bin/bash
set -eu

[ "$UID" -eq 0 ] || { echo "This script must be run as root."; exit 1;}

dconf load / < /data/scripts_conf/gnome.dconf