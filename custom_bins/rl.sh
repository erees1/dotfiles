#!/bin/bash
# readlink -f but copy the result to the clipboard
path=$(readlink -f $@)
echo $path
if tmux info &> /dev/null; then 
    # yk only works in tmux atm
    echo $path | yk
fi
