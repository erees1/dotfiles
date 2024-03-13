# Move pycache files
export PYTHONPYCACHEPREFIX=/tmp/pycache

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  if command pyenv virtualenv --help 1>/dev/null 2>&1; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi
