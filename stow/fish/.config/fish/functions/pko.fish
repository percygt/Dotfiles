function pko --wraps='protonvpn-cli killswitch --off' --description 'alias pko protonvpn-cli killswitch --off'
  protonvpn-cli killswitch --off $argv
        
end
