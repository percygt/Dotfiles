function stowd --description 'stowd <distrobox-name> <dotfiles-folder>'
  if not test -d $DBOX_DIR/$argv[1]/.config/
      mkdir $DBOX_DIR/$argv[1]/.config/
  end
  if test -d $DBOX_DIR/$argv[1]/.config/$argv[2]
      rm -rf $DBOX_DIR/$argv[1]/.config/$argv[2]
  end
  stow -d $HOME/Dotfiles/stow/ -t $DBOX_DIR/$argv[1] $argv[2]
end
