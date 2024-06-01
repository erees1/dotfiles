# 50ms for key sequences
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

# Yank to the system clipboard
function vi-yank-yk {
    zle vi-yank
   echo "$CUTBUFFER" | yk 2> /dev/null
}
function vi-cut-yk {
    zle vi-delete-char
    echo "$CUTBUFFER" | yk 2> /dev/null
}
function vi-delete-yk {
    zle vi-delete
    echo "$CUTBUFFER" | yk 2> /dev/null
}

zle -N vi-yank-yk
zle -N vi-cut-yk
zle -N vi-delete-yk
bindkey -M vicmd 'y' vi-yank-yk
bindkey -M vicmd 'x' vi-cut-yk
bindkey -M vicmd 'd' vi-delete-yk

# To match my custom vim bindings
# bindkey -M vicmd 'H' beginning-of-line
# bindkey -M vicmd 'L' end-of-line


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
