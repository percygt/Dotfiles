function setBashConfig --description 'setBashConfig <root-dir>'
    if not set -q argv[1]
        echo -e "\n#aliases\n[ -f $HOME/.bash_aliases ] && source $HOME/.bash_aliases" >> $HOME/.bashrc
        echo -e "\n#user_configs\n[ -f $HOME/.bash_configs ] && source $HOME/.bash_configs" >> $HOME/.bashrc
        echo ".bash_aliases and .bash_configs is now added to .bashrc"
   else
       echo -e "\n#aliases\n[ -f $DBOX_DIR$argv/.bash_aliases ] && source $DBOX_DIR$argv/.bash_aliases" >> $DBOX_DIR$argv/.bashrc
       echo -e "\n#user_configs\n[ -f $DBOX_DIR$argv/.bash_configs ] && source $DBOX_DIR$argv/.bash_configs" >> $DBOX_DIR$argv/.bashrc
       echo ".bash_aliases and .bash_configs is now added to .bashrc"   
    end
end
