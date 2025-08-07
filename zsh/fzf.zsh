eval "$(fzf --zsh)"

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

# use bat as the previewer for fzf if it is installed
if command -v bat &> /dev/null; then
  preview="bat --style=full --color=always {}"
  else
  preview="cat {}"
fi

__fsel_files() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  eval "find . -not -path '*/\.git/*' -type f -print" | fzf --preview=$preview -m "$@"  | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

function fzf-vim {
    selected=$(__fsel_files)
    if [[ -z "$selected" ]]; then
        zle redisplay
        return 0
    fi
    zle push-line # Clear buffer
    BUFFER="v $selected";
    zle accept-line
}
zle -N fzf-vim
bindkey "^v" fzf-vim