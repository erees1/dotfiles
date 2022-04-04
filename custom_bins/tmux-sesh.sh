#!/bin/bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/git /perish_aml02/edwardr/git -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

is_running=$(ps -aux | grep '[t]mux new-session')
if tmux info &> /dev/null; then 
    is_inside="true"
fi

selected_name=$(basename "$selected" | tr . _)

if [[ -z $TMUX ]] && [[  -z $is_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

if [[ -z $is_inside ]]; then
    tmux attach -t $selected_name
fi

tmux switch-client -t $selected_name
