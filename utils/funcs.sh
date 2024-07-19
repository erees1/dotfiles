function add_to_path() {
  p=$1
  # Add to path if not already there and directory exists
  if [[ "$PATH" != *"$p"* && -d "$p" ]]; then
    export PATH="$p:$PATH"
  fi
}

function add_to_fpath() {
  p=$1
  if [[ "$fpath" != *"$p"* ]]; then
    fpath=($1 $fpath)
  fi
}

