function stowh --wraps='cd ~/Dotfiles/stow/ && stow -t /home/percygt/' --wraps='stow -d ~/Dotfiles/stow/ -t /home/percygt/' --description 'alias stowh stow -d ~/Dotfiles/stow/ -t /home/percygt/'
  stow -d ~/Dotfiles/stow/ -t /home/percygt/ $argv
        
end
