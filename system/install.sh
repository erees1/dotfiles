#! /usr/bin/env zsh
SRC_DIR=$(dirname "$0")

# System tools / utilities
if [ "$(uname -s)" = "Darwin" ]
then
  brew install exa
  brew install fzf
  brew install htop
else
  sudo apt install exa
  sudo apt install fzf
fi
