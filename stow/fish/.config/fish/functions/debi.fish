function debi --wraps='distrobox enter debian-distrobox -nw -- fish -l' --description 'alias debi distrobox enter debian-distrobox -nw -- fish -l'
  distrobox enter debian-distrobox -nw -- fish -l $argv
        
end
