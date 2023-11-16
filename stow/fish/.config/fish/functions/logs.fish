function logs --wraps='cd ~/Logs && tail -n40' --description 'alias logs cd ~/Logs && tail -n40'
  cd ~/Logs && tail -n40 $argv | bat -l log
end
