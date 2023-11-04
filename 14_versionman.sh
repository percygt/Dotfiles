#!/bin/bash
set -eu

[ "$UID" -ne 0 ] || { echo "This script must be run by $SUDO_USER."; exit 1;}

#pyenv
curl https://pyenv.run | bash
echo -e '\n#pyenv' >> ~/.bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

#gobrew
curl -sLk https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh | sh
echo -e '\n#gobrew' >> ~/.bashrc
echo 'export PATH="$HOME/.gobrew/current/bin:$HOME/.gobrew/bin:$PATH"' >> ~/.bashrc
echo 'export GOROOT="$HOME/.gobrew/current/go"' >> ~/.bashrc

#nvm
echo -e '\n#nvm' >> ~/.bashrc
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

#poetry
curl -sSL https://install.python-poetry.org | python3 -