function suicons --wraps='sudo cp -r .icons/. /usr/share/icons/' --wraps='sudo cp -r ~/.local/share/icons/. /usr/share/icons/' --wraps='sudo rsync -rhP ~/.local/share/icons/ /usr/share/icons' --description 'alias suicons sudo rsync -rhP ~/.local/share/icons/ /usr/share/icons'
  sudo rsync -rhP ~/.local/share/icons/ /usr/share/icons $argv
        
end
