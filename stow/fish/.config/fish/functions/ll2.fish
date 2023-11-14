function ll2 --wraps='ls -alFT=2' --wraps='ls -lTL=2' --wraps='ll -TL=2' --description 'alias ll2 ll -TL=2'
  ll -TL=2 $argv
        
end
