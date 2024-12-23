bindkey -r "^R"  # Remove ctrl-r binding

# FZF options - might also affect fzf-lua extenstion in vim
export FZF_DEFAULT_OPTS=" --height ${FZF_TMUX_HEIGHT:-40%} --reverse"

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected="$(fc -rli 1 | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |
    FZF_DEFAULT_OPTS="--height=5% -n2..,.. --scheme=history --bind=ctrl-r:toggle-sort,ctrl-z:ignore ${FZF_CTRL_R_OPTS-} --query=${(qqq)LBUFFER} +m" $(__fzfcmd))"
  local ret=$?
  if [ -n "$selected" ]; then
    num=$(awk '{print $1}' <<< "$selected")
    if [[ "$num" =~ '^[1-9][0-9]*\*?$' ]]; then
      zle vi-fetch-history -n ${num%\*}
    else # selected is a custom query, not from history
      LBUFFER="$selected"
    fi
  fi
  zle reset-prompt
  return $ret
}
zle     -N            fzf-history-widget
bindkey -M emacs '^R' fzf-history-widget
bindkey -M vicmd '^R' fzf-history-widget
bindkey -M viins '^R' fzf-history-widget

history-backsearch() {
  if [[ -z $BUFFER ]]; then
    zle up-history
  else
    zle fzf-history-widget
  fi
}

zle -N history-backsearch
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^[[A' history-backsearch

# Use c-b to go to start of line c-a as tmux leader
bindkey -r "^a"
# bindkey -s '^a' "tsesh\n"
bindkey -r '^b'

# Set Up and Down arrow keys to the (zsh-)history-substring-search plugin
# `-n` means `not empty`, equivalent to `! -z`
# [[ -n "${terminfo[kcuu1]}" ]] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
# [[ -n "${terminfo[kcud1]}" ] fzf-history-widget] && bindkey "${terminfo[kcud1]}" history-substring-search-down
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down
# set ctrl + p and ctrl + n to do up and down arrow
