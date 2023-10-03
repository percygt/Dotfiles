function fedo --wraps='distrobox enter fedora-distrobox -nw -- fish -l' --description 'alias fedo distrobox enter fedora-distrobox -nw -- fish -l'
  distrobox enter fedora-distrobox -nw -- fish -l $argv
        
end
