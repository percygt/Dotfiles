function fedo --wraps='distrobox enter fedora-distrobox -nw -- fish -l' --wraps='distrobox enter fedora-distrobox -nw -a "env TERM=xterm-256color" -- fish -l' --wraps='distrobox enter fedora-distrobox -a "--env TERM=xterm-256color" -nw -- fish -l' --description 'alias fedo distrobox enter fedora-distrobox -a "--env TERM=xterm-256color" -nw -- fish -l'
  distrobox enter fedora-distrobox -a "--env TERM=xterm-256color" -nw -- fish -l $argv
        
end
