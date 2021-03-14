#!/bin/bash


ln -sf "$HOME/git/dotfiles/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"

# Compile Kitty Terminfo if on UCL
if [ $LOC == "UCL" ] ; then
   tic -x -o $HOME/.terminfo $HOME/git/kitty/xterm-kitty
fi
