#!/bin/bash
set -eu

#gobrew
if [[ -e "$HOME/.gobrew"  ]] ; then
  echo "Gobrew is already installed at $HOME/.gobrew"
else
  curl -sLk https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh | sh
  echo -e '\n#gobrew' >> ~/.bashrc
  echo 'export PATH="$HOME/.gobrew/current/bin:$HOME/.gobrew/bin:$PATH"' >> ~/.bashrc
  echo 'export GOROOT="$HOME/.gobrew/current/go"' >> ~/.bashrc
fi