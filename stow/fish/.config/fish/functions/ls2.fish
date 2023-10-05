function ls2 --wraps='exa --icons -F -H --group-directories-first -1 -T -L=2' --wraps='ls -TL=2' --description 'alias ls2 ls -TL=2'
  ls -TL=2 $argv
        
end
