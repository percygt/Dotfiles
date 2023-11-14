function ll3 --wraps='ls -alFT=3' --wraps='ls -lTL=3' --wraps='ll -TL=3' --description 'alias ll3 ll -TL=3'
  ll -TL=3 $argv
        
end
