#!/bin/bash
if [ "$(uname -s)" == "Darwin" ]
then
  brew install nvim
  # Node is used to install language servers in vim/setup_init.sh
  # also requried for vim copilot extension
  brew install node@16
  # Ensure vim language servers are installed
  brew install ripgrep
fi

if [ ! -z $LOC ] && [ $LOC = "remote" ] ; then
  echo "require('remote')" >> $HOME/.config/nvim/init.lua
  # Install langauge servers required by nvim
  npm config set prefix "$HOME/.npm-global"
fi

# Install language servers with npm
if ! command -v pyright 1>/dev/null 2>&1; then
  npm i -g pyright
else
  echo "VIM - found pyright binary - skipping install"
fi
if ! command -v bash-language-server 1>/dev/null 2>&1; then
  npm i -g bash-language-server
else
  echo "VIM - found bash-language-server binary - skipping install"
fi

if ! command -v vscode-html-language-server 1>/dev/null 2>&1; then
  npm i -g vscode-langservers-extracted
else
  echo "VIM - found html-language-server binary - skipping install"
fi

if ! command -v stylua 1>/dev/null 2>&1; then
  npm i -g @johnnymorganz/stylua-bin 
else
  echo "VIM - found stylua found - skipping install"
fi
