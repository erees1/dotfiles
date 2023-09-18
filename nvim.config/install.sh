#!/bin/bash
if [ "$(uname -s)" == "Darwin" ]
then
  brew install nvim
  # Ensure vim language servers are installed
  brew install ripgrep
fi