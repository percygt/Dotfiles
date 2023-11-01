#!/bin/bash
set -eu

[ "$UID" -eq 0 ] || { echo "This script must be run as root."; exit 1;} # Need to figure out how to pkexec so we only ask for the password once.


echo -e "Unsetting grub menu auto hide . . .\n"
grub2-editenv - unset menu_auto_hide

echo -e "Setting filesystem label as 'FEDORA' . . .\n"
btrfs filesystem label / FEDORA

btrfs filesystem show

[ -f ./scripts/set_repo ] && source ./scripts/set_repo

echo $USER
dnf clean all
dnf makecache
dnf up

systemctl reboot