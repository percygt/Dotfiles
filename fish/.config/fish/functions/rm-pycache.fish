function rm-pycache --wraps='find . -type d -name  "__pycache__" -exec rm -r {} +' --description 'alias rm-pycache=find . -type d -name  "__pycache__" -exec rm -r {} +'
  find . -type d -name  "__pycache__" -exec rm -r {} + $argv
        
end
