#!/bin/bash

dir="$HOME/.config/kitty"
mkdir -p $dir

# kitty.conf governs stuff like keyboard shortcuts
ln -sf "$HOME/git/dotfiles/kitty/kitty.conf" "$dir/kitty.conf"


# Compile Kitty Terminfo 
if [ $terminfo == true ] ; then
   mkdir -p $HOME/.terminfo
   tic -x -o $HOME/.terminfo $HOME/git/dotfiles/kitty/xterm-kitty
   echo "Compiled terminfo for kitty"
fi
