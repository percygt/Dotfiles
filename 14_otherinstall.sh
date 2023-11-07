#!/bin/bash
set -eu

[ "$UID" -ne 0 ] || { echo "This script must be run by $SUDO_USER."; exit 1;}


# [[ -e ./install_scripts  ]] && source ./install_scripts/*

OTHER_INSTALL=($(\ls -d ./install_scripts/*))

for sc in "${OTHER_INSTALL[@]}" ; do
  echo "installing ${sc}"
  sh ${sc}
done