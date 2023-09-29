function dt --wraps='docker logs --tail 1000 -f' --description 'alias dt=docker logs --tail 1000 -f'
  docker logs --tail 1000 -f $argv | lolcat
        
end
