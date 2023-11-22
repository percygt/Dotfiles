#!/bin/bash
set -eu

[ "$UID" -eq 0 ] || { echo "This script must be run as root."; exit 1;}



#### Get the UUID of your btrfs system root.
ROOT_UUID="$(grub2-probe --target=fs_uuid /)"

#### Get the btrfs subvolume mount options from your fstab.
OPTIONS="compress=lzo"

#### Declare rest of the subvolumes you want to create in the array.
#### Copy from 'SUBVOLUMES' to ')', paste it in terminal, and hit <Enter>.
SUBVOLUMES=(
    "opt"
    "nix"
    "var/cache"
    "var/crash"
    "var/log"
    "var/spool"
    "var/tmp"
    "var/www"
    "var/lib/AccountsService"
    "var/lib/gdm"
    "home/$SUDO_USER/.mozilla"
    "home/$SUDO_USER/.config/BraveSoftware"
)

#### Run the for loop to create the subvolumes.
#### Copy from 'for' to 'done', paste it in terminal, and hit <Enter>.
for dir in "${SUBVOLUMES[@]}" ; do
    if [[ -d "/${dir}" ]] ; then
        mv -v "/${dir}" "/${dir}-old"
        btrfs subvolume create "/${dir}"
        cp -ar "/${dir}-old/." "/${dir}/"
    else
        btrfs subvolume create "/${dir}"
    fi
    restorecon -RF "/${dir}"
    printf "%-41s %-35s %-5s %-s %-s\n" \
        "UUID=${ROOT_UUID}" \
        "/${dir}" \
        "btrfs" \
        "subvol=${dir},${OPTIONS}" \
        "0 0" | \
        tee -a /etc/fstab
done

chmod 1777 /var/tmp
chmod 1770 /var/lib/gdm
chown -R $SUDO_USER: /home/$SUDO_USER/.mozilla
chown -R $SUDO_USER: /home/$SUDO_USER/.config/BraveSoftware

systemctl daemon-reload
mount -va

for dir in "${SUBVOLUMES[@]}" ; do
    if [[ -d "/${dir}-old" ]] ; then
        rm -rf "/${dir}-old"
    fi
done

btrfs subvolume list /
