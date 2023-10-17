function setdbox --description 'stowd <distrobox-name>'
    set aliases (grep "#aliases" $DBOX_DIR/$argv/.bashrc)
    set user_configs (grep "#user_configs" $DBOX_DIR/$argv/.bashrc)
    if not test -d $DBOX_DIR/$argv[1]/.config/
      mkdir $DBOX_DIR/$argv[1]/.config/
    end
    if test -d $DBOX_DIR/$argv[1]/.config/fish/
        cp -r $HOME/Dotfiles/distrobox/fish/*  $DBOX_DIR/$argv[1]/.config/fish
    else
        cp -r $HOME/Dotfiles/distrobox/fish/  $DBOX_DIR/$argv[1]/.config/
    end
    not test -n "$aliases"; and echo -e "\n#aliases\n[ -f $DBOX_DIR/$argv[1]/.bash_aliases ] && source $DBOX_DIR/$argv[1]/.bash_aliases" >> $DBOX_DIR/$argv[1]/.bashrc;
    not test -n "$user_configs"; and echo -e "\n#user_configs\n[ -f $DBOX_DIR/$argv[1]/.bash_configs ] && source $DBOX_DIR/$argv[1]/.bash_configs" >> $DBOX_DIR/$argv[1]/.bashrc

    cp -r $HOME/Dotfiles/distrobox/fastfetch/  $DBOX_DIR/$argv[1]/.config/
    cp -r $HOME/Dotfiles/distrobox/starship.toml  $DBOX_DIR/$argv[1]/.config/
    cp -r $HOME/Dotfiles/distrobox/.bash_aliases  $DBOX_DIR/$argv[1]/
    cp -r $HOME/Dotfiles/distrobox/.bash_configs  $DBOX_DIR/$argv[1]/


end
