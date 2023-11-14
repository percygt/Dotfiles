function ll --wraps='ls -alF' --wraps='ls -la' --wraps='ls -l' --wraps='ls -lgMHi' --wraps='ls -lgMHiZ' --description 'alias ll ls -lgMHiZ'
  ls -lgMHiZ $argv
        
end
