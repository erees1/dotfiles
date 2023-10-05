#!/bin/bash

tmuxVersion=$(tmux -V | cut -d ' ' -f 2 | tr -d '[:alpha:]')

if (( $(echo "$tmuxVersion >= 3.2" | bc -l) )); then
    tmux bind N display-popup -w 80% -h 90% -E 'tmux new-session -A -s scratch'
    tmux bind q display-popup -w 80% -h 90% -E 'qstat -q "aml-gpu.q@*" -f -u * | less'
    tmux bind O display-popup -w 80% -h 90% -E 'cd $DOT_DIR && nvim'
    tmux bind Tab run-shell 'tsesh --popup'
fi

