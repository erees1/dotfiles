#! /usr/bin/env zsh  
SRC_DIR=$(dirname "$0")

# Node
mkdir -p ~/.nvm
brew install nvm

. $SRC_DIR/node.zsh

nvm install 16
nvm use 16
nvm alias default 16