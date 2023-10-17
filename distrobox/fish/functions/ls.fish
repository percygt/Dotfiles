function ls --wraps='exa -la' --wraps='exa --long --header --git' --wraps='exa --icons -F -H --group-directories-first --git -1' --wraps='exa --icons -FH --time-style=long-iso --group-directories-first -1' --wraps='exa --icons -FH --group-directories-first -1' --wraps='exa --icons -F -H --group-directories-first -1' --description 'alias ls exa --icons -F -H --group-directories-first -1'
  exa --icons -F -H --group-directories-first -1 $argv
        
end
