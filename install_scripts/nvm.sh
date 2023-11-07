#!/bin/bash
set -eu


if [[ -e "$HOME/.nvm"  ]] ; then
  echo "NVM is already installed at $HOME/.nvm"
else
  echo -e '\n#nvm' >> ~/.bashrc
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
fi