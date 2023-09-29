function arch --wraps='distrobox enter arch-distrobox -nw -- fish -l' --description 'alias arch distrobox enter arch-distrobox -nw -- fish -l'
  distrobox enter arch-distrobox -nw -- fish -l $argv
        
end
