# inserts shim for .rbenv if its not there already
if hash rbenv 2>/dev/null; then
  SUB='rbenv/shims'
  if [[ "$PATH" != *"$SUB"* ]]; then
    eval "$(rbenv init -)"
  fi
fi
