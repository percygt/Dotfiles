function suthemes --wraps='sudo cp -r .themes/. /usr/share/themes/' --wraps='sudo cp -r ~/.local/share/themes/. /usr/share/themes/' --description 'alias suthemes sudo cp -r ~/.local/share/themes/. /usr/share/themes/'
  sudo cp -r ~/.local/share/themes/. /usr/share/themes/ $argv
        
end
