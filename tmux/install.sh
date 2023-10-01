#!/bin/bash

SRC_DIR=$(dirname "$0")


if [ "$(uname -s)" == "Darwin" ]
then
  brew install tmux

else
  sudo apt install tmux
fi


# Install tmux plugin manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
