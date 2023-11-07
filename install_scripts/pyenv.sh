#!/bin/bash
set -eu


if [[ -e "$HOME/.pyenv"  ]] ; then
  echo "Pyenv is already installed at $HOME/.pyenv"
else
  curl https://pyenv.run | bash
  echo -e '\n#pyenv' >> ~/.bashrc
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
  echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(pyenv init -)"' >> ~/.bashrc
fi
