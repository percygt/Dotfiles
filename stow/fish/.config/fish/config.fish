if status is-interactive
	fastfetch
 # Commands to run in interactive sessions can go here
end

function starship_transient_prompt_func
  starship module character
end
starship init fish | source
enable_transience

pyenv init - | source
