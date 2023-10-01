#! /usr/bin/env zsh
SRC_DIR=$(dirname "$0")

# System tools / utilities
if [ "$(uname -s)" = "Darwin" ]
then
  brew install exa
  brew install fzf
  brew install htop
else
  # Just use the no root versions so that e.g. fzf uses a later version 
  $SRC_DIR/install_no_root.sh
fi
