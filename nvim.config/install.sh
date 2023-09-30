#!/bin/bash
SRC_DIR=$(dirname "$0")

if [ "$(uname -s)" == "Darwin" ]
then
  brew install nvim
  # Ensure vim language servers are installed
  brew install ripgrep
else
  $SRC_DIR/install_no_root.sh  
fi