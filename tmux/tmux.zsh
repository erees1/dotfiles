alias ta="tmux attach"
alias taa="tmux attach -t"
alias tad="tmux attach -d -t"
alias td="tmux detach"
alias ts="tmux new-session -s"
alias tl="tmux list-sessions"
tkill(){
    tmux kill-server
    ps aux | grep '[t]mux' | awk '{print $2}' | xargs kill -9
}
alias tdel="tmux kill-session -t"