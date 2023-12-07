#!/bin/bash
set -eu

[ "$UID" -eq 0 ] || { echo "This script must be run as root."; exit 1;}

setenforce 0
## https://linux.die.net/man/8/rsync_selinux
setsebool -P rsync_export_all_ro 1
setsebool -P allow_rsync_anon_write 1
checkmodule -M -m -o /tmp/rsync-pipe.mod ./files/rsync-pipe.te
semodule_package -o /tmp/rsync-pipe.pp -m /tmp/rsync-pipe.mod
semodule -i /tmp/rsync-pipe.pp

setenforce 1

## https://unix.stackexchange.com/questions/534131/rsync-daemon-with-enforcing-selinux-policy-rsync-export-all-ro-still-prevents-ac
## put SELinux in permissive mode
#setenforce 0

## --- do your rsync stuff ---

## get related AVC denials
## I'm using 'recent' here, depending on the rsync run time please adjust accordingly
#ausearch -m avc -ts recent --subject rsync_t

## go through the output. If you're satisfied, create the module
#ausearch -m avc -ts recent --subject rsync_t | audit2allow -m roaima-rsync-custom-1 > roaima-rsync-custom-1.te
#checkmodule -M -m -o roaima-rsync-custom-1.mod roaima-rsync-custom-1.te
#semodule_package -o roaima-rsync-custom-1.pp -m roaima-rsync-custom-1.mod

## load the policy module
#semodule -i roaima-rsync-custom-1.pp

# disable permissive mode
#setenforce 1

# --- do your rsync stuff again --