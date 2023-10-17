function ls3 --wraps='exa --icons -F -H --group-directories-first -1 -T -L=3' --wraps='ls -TL=3' --description 'alias ls3 ls -TL=3'
  ls -TL=3 $argv
        
end
