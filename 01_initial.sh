#!/bin/bash
set -eu

[ "$UID" -eq 0 ] || { echo "This script must be run as root."; exit 1;}

sed -i 's/zstd:1/lzo/g' /etc/fstab

COMMON=lsblk -f | awk '/COMMON/{print $4}'
BACKUP=lsblk -f | awk '/BACKUP/{print $4}'
WINDOWS=lsblk -f | awk '/WINDOWS/{print $4}'

echo -e "Unsetting grub menu auto hide . . .\n"
grub2-editenv - unset menu_auto_hide

echo -e "Setting filesystem label as 'FEDORA' . . .\n"
btrfs filesystem label / FEDORA

btrfs filesystem show

[ -e ./repos ] && cp -Rnvp ./repos/* /etc/yum.repos.d/ &&


#Docker
echo "Settiing Docker repo . . ."
dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

#fedora-cisco-openh264
echo "Settiing Openh264 repo. . ."
dnf config-manager --set-enabled fedora-cisco-openh264

#COPR
echo "Settiing Copr and rpmfusion repos. . ."
dnf -y copr enable lukenukem/asus-linux
#RPMfusion
dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

chown $SUDO_USER -R /data

dnf clean all
dnf makecache
dnf update

systemctl reboot