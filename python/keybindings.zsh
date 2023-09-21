# convert a python command to a debug command
function replace-python {
  if [[ $BUFFER =~ ^python\ .* ]]; then
    BUFFER="python3 -m debugpy --listen 5678 --wait-for-client ${BUFFER#python }"
    CURSOR+=51
    zle reset-prompt
  fi
}
zle -N replace-python
bindkey "\ed" replace-python

