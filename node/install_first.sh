#! /usr/bin/env zsh  
SRC_DIR=$(dirname "$0")
. $SRC_DIR/node.zsh

if [ "$(uname -s)" = "Darwin" ]
then
    # Node
    mkdir -p ~/.nvm
    brew install nvm

    . $SRC_DIR/node.zsh

else
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
    . $SRC_DIR/node.zsh
fi
nvm install 16
nvm use 16
nvm alias default 16
