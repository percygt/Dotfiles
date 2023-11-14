#!/bin/bash
set -eu

[ "$UID" -ne 0 ] || { echo "This script must be run by $SUDO_USER."; exit 1;}

FOLDERS=($(\ls -d /data/shared_home/* | awk -F/ '{print $4}'| tr '\n' ' '))

for dir in "${FOLDERS[@]}" ; do
  [[ -e "$HOME/${dir}"  ]] && [[ ! -L "$HOME/${dir}" ]] && rm -rf "$HOME/${dir}"
done

stow -d /data/ -t $HOME shared_home/


grep "#aliases" $HOME/.bashrc || echo -e "\n#aliases\n[ -f $HOME/.bash_aliases ] && source $HOME/.bash_aliases" >> $HOME/.bashrc
grep "#user_configs" $HOME/.bashrc || echo -e "\n#user_configs\n[ -f $HOME/.bash_configs ] && source $HOME/.bash_configs" >> $HOME/.bashrc

[[ ! -e "$HOME/.local/share/gnome-shell/extensions/"  ]] && mkdir -p $HOME/.local/share/gnome-shell/extensions/
echo "copying extensions . . ."
rsync -arhP /data/extensions/* $HOME/.local/share/gnome-shell/extensions/ &&


EXT_INSTALL=($(\ls -d /data/ext_install/*))

for dir in "${EXT_INSTALL[@]}" ; do
  echo "installing ${dir}"
  gnome-extensions install "${dir}" --force
done

/data/utils/libadwaita-theme-changer/libadwaita-tc.py
/data/utils/stylepak-master/stylepak install-system

echo "copying cphome . . ."
rsync -arhP /data/cp_home/* $HOME/ &&

sudo sed -i "s/#Experimental = false/Experimental = true/" /etc/bluetooth/main.conf
echo "Reboot to apply changes"