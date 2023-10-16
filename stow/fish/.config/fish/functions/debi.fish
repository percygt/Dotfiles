function debi --wraps='distrobox enter debian-distrobox -nw -- fish -l' --wraps='distrobox enter debian-distrobox -a "--env TERM=xterm-256color" -nw -- fish -l' --description 'alias debi distrobox enter debian-distrobox -a "--env TERM=xterm-256color" -nw -- fish -l'
  distrobox enter debian-distrobox -a "--env TERM=xterm-256color" -nw -- fish -l $argv
        
end
