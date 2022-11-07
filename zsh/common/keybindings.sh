# vim mode config

# Activate vim mode.
bindkey -v

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

# git add ci and push
function git_prepare() {
   if [ -n "$BUFFER" ]; then
	BUFFER="git add -u && git commit -m \"$BUFFER\" "
   fi

   if [ -z "$BUFFER" ]; then
	BUFFER="git add -u && git commit -v "
   fi
		
   zle accept-line
}
zle -N git_prepare
bindkey -r "\eg"
bindkey "\eg" git_prepare

function prepend-sudo {
  if [[ $BUFFER != "sudo "* ]]; then
    BUFFER="sudo $BUFFER"; CURSOR+=5
    zle reset-prompt
  fi
}
zle -N prepend-sudo
bindkey "\es" prepend-sudo

__fsel_files() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  eval "find . -not -path '*/\.git/*' -type f -print" | fzf -m "$@" | while read item; do
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

# Set Up and Down arrow keys to the (zsh-)history-substring-search plugin
# `-n` means `not empty`, equivalent to `! -z`
[[ -n "${terminfo[kcuu1]}" ]] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
[[ -n "${terminfo[kcud1]}" ]] && bindkey "${terminfo[kcud1]}" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# Accept zsh autosggestions with ctrl + space
# Make sure you don't have mac input source switch
bindkey '^ ' autosuggest-accept  

bindkey -s ^f "tsesh --popup\n"

# To match my custom vim bindings
bindkey -M vicmd 'H' beginning-of-line
bindkey -M vicmd 'L' end-of-line

# Use c-b to go to start of line c-a as tmux leader
bindkey -r "^a"
bindkey -s '^a' "tsesh\n"
bindkey -r '^b'
bindkey -M viins '^b' beginning-of-line
bindkey -M viins '^e' end-of-line

