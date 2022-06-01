#!/bin/bash
# readlink -f but copy the result to the clipboard
set -euo pipefail
path=$(readlink -f $@)
if tmux info &> /dev/null; then 
    # yk only works in tmux atm
    echo $path | yk
    echo $path copied to clipboard
else
    echo $path
fi
