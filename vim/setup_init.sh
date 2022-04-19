#!/bin/bash
# Neovim
if [ ! -d $HOME/.config/nvim ]; then
    mkdir -p $HOME/.config/nvim;
fi

# Neovim setup
echo "require('init')" > $HOME/.config/nvim/init.lua
echo "require('init-light')" > $HOME/.config/nvim/init-light.lua
# echo "vim.cmd('source $HOME/git/dotfiles/vim/vimscript/init.vim')" >> $HOME/.config/nvim/init.lua

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

# Remove init.vim if exists as it will conflict with init.lua
if [ -f $HOME/.config/nvim/init.vim ]; then
  rm $HOME/.config/nvim/init.vim
fi

ln -sf $HOME/git/dotfiles/vim/lua $HOME/.config/nvim
ln -sf $HOME/git/dotfiles/vim/colors $HOME/.config/nvim

