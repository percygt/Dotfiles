function activate_p --wraps='source "$( poetry env info --path )/bin/activate.fish"' --description 'alias activate_p source "$( poetry env info --path )/bin/activate.fish"'
  source "$( poetry env info --path )/bin/activate.fish" $argv
        
end
