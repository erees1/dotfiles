#-------------------------------------------------------------
# Vi mode activation
#-------------------------------------------------------------

# Activate vim mode.
bindkey -v
# You need these here otherwise if you go into normal mode and then back to insert
# mode the delete key doesn't work, on testing it seems I only need ^? in mac terminal but I kept both
# of suggested here: https://vi.stackexchange.com/questions/31671/set-o-vi-in-zsh-backspace-doesnt-delete-non-inserted-characters
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

# Add keybindings for ctrl-b and ctrl-e to go to beginning/end of line in insert mode
bindkey -M viins '^U' beginning-of-line
bindkey -M viins '^E' end-of-line

# Add keybindings for ctrl-n and ctrl-p to work like up/down arrows
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^N' down-line-or-history
bindkey -M vicmd '^P' up-line-or-history
bindkey -M vicmd '^N' down-line-or-history

#-------------------------------------------------------------
# zsh extra settings
#-------------------------------------------------------------

unsetopt completealiases          # Complete aliases as if they were commands
setopt RM_STAR_WAIT               # Wait when typing `rm *` before being able to confirm
setopt NO_BEEP                    # Don't beep on errors in ZLE
setopt HIST_REDUCE_BLANKS         # Remove superfluous blanks before recording entry.
setopt HIST_IGNORE_SPACE          # Don't record an entry starting with a space.
setopt HIST_NO_STORE              # Remove the history (fc -l) command from the history.
setopt EXTENDED_HISTORY           # Write the history file in the ":start:elapsed;command" format.
setopt HIST_SAVE_NO_DUPS          # Don't write duplicate entries in the history file.
setopt HIST_EXPIRE_DUPS_FIRST     # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS          # Do not display a line previously found.
setopt INC_APPEND_HISTORY         # New lines are added to $HISTFILE incrementally, rather than waiting until the shell exits
setopt always_to_end
setopt list_ambiguous
zstyle ':completion:*' hosts off  # Don't autocomple ssh host names
ZSH_DISABLE_COMPFIX=true


# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

#-------------------------------------------------------------
# Key bindings
#-------------------------------------------------------------

# Accept zsh autosggestions with ctrl + space
# Make sure you don't have mac input source switch
bindkey '^ ' autosuggest-accept

function prepend-sudo {
  if [[ $BUFFER != "sudo "* ]]; then
    BUFFER="sudo $BUFFER"
    CURSOR+=5
    zle reset-prompt
  fi
}
zle -N prepend-sudo
bindkey "\es" prepend-sudo

#-------------------------------------------------------------
# Vi mode configuration
#-------------------------------------------------------------

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