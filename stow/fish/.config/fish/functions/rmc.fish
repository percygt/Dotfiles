function rmc --wraps='git rm --cached */__pycache__/*' --description 'alias rmc git rm --cached */__pycache__/*'
  git rm --cached */__pycache__/* $argv
        
end
