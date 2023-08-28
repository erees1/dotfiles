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
