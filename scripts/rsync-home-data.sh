#!/bin/bash

yq=/home/percygt/.nix-profile/bin/yq
# Check if yq is installed
if ! command -v $yq &> /dev/null; then
    echo "yq is not installed. Please install it before running this script."
    exit 1
fi
config="/data/rsync_home/config.yaml"
# Read YAML using yq
root_data_dir=$($yq -r '.root_data_dir' $config)
root_home_dir=$($yq -r '.root_home_dir' $config)

# Loop through items and perform rsync
items=$($yq -c '.items[]' $config)
while IFS= read -r items; do
    data_dir=$(echo "$items" | $yq -r '.data_dir')
    home_dir=$(echo "$items" | $yq -r '.home_dir')
    skip_backup=$(echo "$items" | $yq -r '.skip_backup // 0' -)

    # Skip backup if skip_backup is set to 1
    if [ "$skip_backup" -eq 1 ]; then
        echo "Skipping backup for $home_dir (skip_backup is set to 1)"
        continue
    fi
    echo "from $home_dir to $data_dir"
    # Run rsync command
    rsync -av --delete \
    --exclude-from=<(find $root_data_dir/$data_dir -type l -exec sh -c 'readlink -f "$0" | grep -q "/nix" && echo "$0"' {} \;) \
    "$root_home_dir/$home_dir/" "$root_data_dir/$data_dir/"

done <<< "$items"
