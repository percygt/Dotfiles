# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*;
	do if [ -f "$rc" ]; then
		. "$rc"
		fi
	done
fi


unset rc
eval "$(starship init bash)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

#distrobox
alias fi="fish"
alias f39="distrobox enter f39 -nw -- fish -l"
alias f38="distrobox enter f38 -nw -- fish -l"
alias u23="distrobox enter u23 -nw -- fish -l"

alias ls="exa -la"

export PATH="${PATH}:${HOME}/.local/bin/"

alias rmc='git rm --cached */__pycache__/*'

. "$HOME/.cargo/env"

export LIBVIRT_DEFAULT_URI="qemu:///system"
