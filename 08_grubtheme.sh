#!/bin/bash
set -eu

[ "$UID" -eq 0 ] || { echo "This script must be run as root."; exit 1;} # Need to figure out how to pkexec so we only ask for the password once.

wget -P /tmp https://github.com/shvchk/poly-dark/raw/master/install.sh

cp files/background.png /boot/grub2/themes/poly-dark/

bash /tmp/install.sh

cat /etc/default/grub
