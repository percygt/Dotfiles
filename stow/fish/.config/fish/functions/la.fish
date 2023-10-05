function la --wraps=ls --wraps='exa -a --long --header --git' --wraps='exa --icons -F -H --group-directories-first --git -1 -a' --wraps='ls -la' --description 'alias la ls -la'
  ls -la $argv
        
end
