#!/bin/bash

dir="$HOME/.config/kitty"
mkdir -p $dir

ln -sf "$HOME/git/dotfiles/kitty/kitty.conf" "$dir/kitty.conf"

mkdir -p $HOME/.terminfo

# Compile Kitty Terminfo if on UCL
if [ $LOC == "ucl" ] ; then
   tic -x -o $HOME/.terminfo $HOME/git/dotfiles/kitty/xterm-kitty
   echo "Compiled terminfo for kitty"
fi
