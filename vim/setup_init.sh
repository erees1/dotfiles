#!/bin/bash
# Neovim
if [ ! -d $HOME/.config/nvim ]; then
    mkdir -p $HOME/.config/nvim;
fi

# Neovim setup
echo "require('init')" > $HOME/.config/nvim/init.lua
if [ $LOC == "remote" ]; then
    echo "require('remote')" >> $HOME/.config/nvim/init.lua
fi
echo "require('init-light')" > $HOME/.config/nvim/init-light.lua

# Remove init.vim if exists as it will conflict with init.lua
if [ -f $HOME/.config/nvim/init.vim ]; then
  rm $HOME/.config/nvim/init.vim
fi

ln -sf $HOME/git/dotfiles/vim/lua $HOME/.config/nvim
ln -sf $HOME/git/dotfiles/vim/colors $HOME/.config/nvim
ln -sf $HOME/git/dotfiles/vim/after $HOME/.config/nvim

