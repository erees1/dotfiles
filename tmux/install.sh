#!/bin/bash
SRC_DIR=$(dirname "$0")

if [ "$(uname -s)" == "Darwin" ]
then
  brew install tmux
else
  # if NO_ROOT is set then install without root permissions
  if [[ -n $NO_ROOT ]]; then
    $SRC_DIR/tmux_from_src.sh 
  else
    sudo apt-get install -y tmux
  fi
fi

# Install tmux plugin manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
