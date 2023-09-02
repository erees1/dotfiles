function add_to_path() {
  p=$1
  if [[ "$PATH" != *"$p"* ]]; then
    export PATH="$p:$PATH"
  fi
}

function add_to_fpath() {
  p=$1
  if [[ "$fpath" != *"$p"* ]]; then
    fpath=($1 $fpath)
  fi
}

