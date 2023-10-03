function la --wraps=ls --wraps='exa -a --long --header --git' --wraps='exa --icons -F -H --group-directories-first --git -1 -a' --description 'alias la=exa --icons -F -H --group-directories-first --git -1 -a'
  exa --icons -F -H --group-directories-first --git -1 -a $argv
        
end
