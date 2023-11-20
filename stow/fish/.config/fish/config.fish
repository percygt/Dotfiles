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

set fzf_configure_bindings --variables=\e\cv
set fzf_fd_opts --hidden --exclude=.git
set fzf_directory_opts --bind "ctrl-e:execute($EDITOR {} &> /dev/tty)" --bind "ctrl-t:execute(code {} &> /dev/tty)"
set GHQ_SELECTOR_OPTS --bind "ctrl-e:execute($EDITOR {} &> /dev/tty)" --bind "ctrl-t:execute(code {} &> /dev/tty)"

