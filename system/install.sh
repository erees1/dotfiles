#!/bin/bash
# System tools
if [ "$(uname -s)" == "Darwin" ]
then
  brew install exa
  brew install fzf
  gem install pro
fi
