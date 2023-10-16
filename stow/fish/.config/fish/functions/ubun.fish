function ubun --wraps='distrobox enter ubuntu-distrobox -a "--env TERM=xterm-256color" -nw -- fish -l' --description 'alias ubun distrobox enter ubuntu-distrobox -a "--env TERM=xterm-256color" -nw -- fish -l'
  distrobox enter ubuntu-distrobox -a "--env TERM=xterm-256color" -nw -- fish -l $argv
        
end
