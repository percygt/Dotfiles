#!/bin/bash
set -eu

[ "$UID" -ne 0 ] || { echo "This script must be run by $SUDO_USER."; exit 1;}

rm -rf $HOME/Documents
rm -rf $HOME/Downloads
rm -rf $HOME/Desktop
rm -rf $HOME/Music
rm -rf $HOME/Pictures
rm -rf $HOME/Videos

stow -d /data/ -t $HOME shared_home/


[ grep "#aliases" $HOME/.bashrc ] || echo -e "\n#aliases\n[ -f $HOME/.bash_aliases ] && source $HOME/.bash_aliases" >> $HOME/.bashrc
[ grep "#user_configs" $HOME/.bashrc ] || echo -e "\n#user_configs\n[ -f $HOME/.bash_configs ] && source $HOME/.bash_configs" >> $HOME/.bashrc

