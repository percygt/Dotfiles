function arch --wraps='distrobox enter arch-distrobox -a "--env TERM=xterm-256color" -nw -- fish -l' --description 'alias arch distrobox enter arch-distrobox -a "--env TERM=xterm-256color" -nw -- fish -l'
  distrobox enter arch-distrobox -a "--env TERM=xterm-256color" -nw -- fish -l $argv
        
end
