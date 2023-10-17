function lsa --wraps='exa --icons -F -H --group-directories-first -1 -T' --wraps='ls -T' --description 'alias lsa ls -T'
  ls -T $argv
        
end
