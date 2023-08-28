#!/bin/bash
# System tools
if [ "$(uname -s)" == "Darwin" ]
then
  brew install exa
  gem install pro
fi