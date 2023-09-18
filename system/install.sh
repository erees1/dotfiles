#! /usr/bin/env zsh
SRC_DIR=$(dirname "$0")

# System tools
if [ "$(uname -s)" = "Darwin" ]
then
  brew install exa
  brew install fzf
fi
