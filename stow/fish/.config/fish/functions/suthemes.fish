function suthemes --wraps='sudo cp -r .themes/. /usr/share/themes/' --wraps='sudo cp -r ~/.local/share/themes/. /usr/share/themes/' --wraps='sudo rsync -rhP ~/.local/share/themes/. /usr/share/themes/' --description 'alias suthemes sudo rsync -rhP ~/.local/share/themes/. /usr/share/themes/'
  sudo rsync -rhP ~/.local/share/themes/. /usr/share/themes/ $argv
        
end
