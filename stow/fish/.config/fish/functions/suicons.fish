function suicons --wraps='sudo cp -r .icons/. /usr/share/icons/' --wraps='sudo cp -r ~/.local/share/icons/. /usr/share/icons/' --description 'alias suicons sudo cp -r ~/.local/share/icons/. /usr/share/icons/'
  sudo cp -r ~/.local/share/icons/. /usr/share/icons/ $argv
        
end
