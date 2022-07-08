function add_to_path() {
    p=$1
    if [[ "$PATH" != *"$p"* ]]; then
      export PATH="$p:$PATH"
    fi
}
