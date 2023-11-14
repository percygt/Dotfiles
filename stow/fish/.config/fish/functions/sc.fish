function sc --wraps='sudo -E systemctl' --description 'alias sc sudo -E systemctl'
  sudo -E systemctl $argv
        
end
