# Move pycache files
export PYTHONPYCACHEPREFIX=/tmp/pycache

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


function fzf-run-python-m {
    {
        local _path=$(find . -name \*.py | fzf | rev | cut -d. -f2- | rev | cut -d/ -f3- | tr '/' '.')
        if [ ! -z "$_path" ]
        then
            BUFFER="python -m $_path "
            zle end-of-line
            zle reset-prompt
        fi
    }
}
zle -N fzf-run-python-m
bindkey '\ep' fzf-run-python-m

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  if command pyenv virtualenv --help 1>/dev/null 2>&1; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi
