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

echo "extensions"
[[ ! -e "$HOME/.local/share/gnome-shell/extensions/"  ]] && mkdir -p $HOME/.local/share/gnome-shell/extensions/

cp -ar /data/extensions/. $HOME/.local/share/gnome-shell/extensions/

echo "cphome"
cp -ar /data/cp_home/. $HOME/
