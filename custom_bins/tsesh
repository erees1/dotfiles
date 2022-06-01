#!/bin/bash

possible_options="$HOME/git"

if [ -d "/perish_aml02" ]; then
    possible_options+=" /perish_aml02/edwardr/git"
fi
exact=" /exp/$(whoami)"

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$({ echo $exact; find $possible_options -mindepth 1 -maxdepth 1 -type d; } | fzf)
fi

if [[ $selected == "/exp/$(whoami)" ]] ; then
    sesh_name="exp"
else
    sesh_name=$(basename "$selected" | tr . _)
fi

if [[ -z $selected ]]; then
    exit 0
fi

is_running=$(ps aux | grep '[t]mux new-session')
if tmux info &> /dev/null; then 
    is_inside="true"
fi


if [[ -z $TMUX ]] && [[  -z $is_running ]]; then
    tmux new-session -s $sesh_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$sesh_name 2> /dev/null; then
    tmux new-session -ds $sesh_name -c $selected
fi

if [[ -z $is_inside ]]; then
    tmux attach -t $sesh_name
fi

tmux switch-client -t $sesh_name
