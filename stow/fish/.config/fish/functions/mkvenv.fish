function mkvenv --wraps='python -m venv venv' --description 'alias mkvenv python -m venv venv'
  python -m venv venv $argv
  source venv/bin/activate.fish        
end
