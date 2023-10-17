function setBashConfig --description 'setBashConfig <root-dir>'
  if $argv[0] = "h"
    echo -e "\n#aliases\n[ -f $HOME/.bash_aliases ] && source $HOME/.bash_aliases" >> $HOME/.bashrc
    echo -e "\n#user_configs\n[ -f $HOME/.bash_configs ] && source $HOME/.bash_configs" >> $HOME/.bashrc
         
    echo ".bash_aliases and .bash_configs is now added to .bashrc"
  
  end
  stow -d $HOME/Dotfiles/stow/ -t $DBOX_DIR/$argv[1] $argv[2]
end