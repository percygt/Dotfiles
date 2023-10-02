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

  #=============================#
  # CONFIGS  			#
  #=============================#

#starship
eval "$(starship init bash)"

#aliases
[ -f $HOME/.bashrc_aliases ] && source $HOME/.bashrc_aliases


#nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

#script
export PATH="${PATH}:${HOME}/.local/bin/"


#cargo
. "$HOME/.cargo/env"

#kvm
export LIBVIRT_DEFAULT_URI="qemu:///system"
