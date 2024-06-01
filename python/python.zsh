# Move pycache files
export PYTHONPYCACHEPREFIX=/tmp/pycache

function fzf-run-python-m {
    {
        local _path=$(find . -name \*.py | fzf | rev | cut -d. -f2- | rev | cut -d/ -f3- | tr '/' '.')
        if [ ! -z "$_path" ]
        then
            BUFFER="python -m $_path "
            zle end-of-line
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
