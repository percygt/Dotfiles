#!/bin/bash
set -eu

[ "$UID" -ne 0 ] || { echo "This script must be run by $SUDO_USER."; exit 1;}

FOLDERS=($(\ls -d /data/stow_home/* | awk -F/ '{print $4}'| tr '\n' ' '))

for dir in "${FOLDERS[@]}" ; do
  [[ -e "$HOME/${dir}"  ]] && [[ ! -L "$HOME/${dir}" ]] && rm -rf "$HOME/${dir}"
done

echo "starting stow. . ."
stow -d /data/ -t $HOME stow_home/

##---------------------------------------------------------------------------------------------------------------------

echo "starting rsync. . ."
# Check if yq is installed
if ! command -v yq &> /dev/null; then
    echo "yq is not installed. Please install it before running this script."
    exit 1
fi

# Read YAML using yq
config="/data/rsync_home/config.yaml"

# Read YAML using yq
root_dir1=$(yq -r '.root_dir1' $config)
root_dir2=$(yq -r '.root_dir2' $config)

# Loop through items and perform rsync
items=$(yq -c '.items[]' $config)
while IFS= read -r items; do
    dir1=$(echo "$items" | yq -r '.dir1')
    dir2=$(echo "$items" | yq -r '.dir2')

    # Run rsync command
    rsync -v --ignore-existing "$root_dir1/$dir1/" "$root_dir2/$dir2/"
done <<< "$items"


##-----------------------------------------------------------------------------------------------------
EXT_INSTALL=($(\ls -d /data/ext_install/*))

for dir in "${EXT_INSTALL[@]}" ; do
  echo "installing ${dir}"
  gnome-extensions install "${dir}" --force
done

/data/utils/stylepak-master/stylepak install-system
# /data/utils/libadwaita-theme-changer/libadwaita-tc.py

echo "Reboot to apply changes"
