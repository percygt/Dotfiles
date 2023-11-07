#!/bin/bash
set -eu


if [[ -e "$HOME/.local/share/pypoetry/"  ]] ; then
  echo "Poetry is already installed at $HOME/.local/share/pypoetry/"
else
  curl -sSL https://install.python-poetry.org | python3 -
fi
