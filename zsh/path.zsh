add_to_path "/opt/homebrew/opt/node@16/bin"
add_to_path "${DOT_DIR}/bin"
add_to_path "${HOME}/.local/bin"

if [ -d "$MY_BIN_LOC" ]; then
  add_to_path "$MY_BIN_LOC"
fi
