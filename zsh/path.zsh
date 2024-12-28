typeset -Ug path PATH
function _maybe_append_path() {
    if [ -d "$1" ]; then
        path=("${path[@]}" "$1")
    fi
}

_maybe_append_path "/opt/homebrew/opt/node@16/bin"
_maybe_append_path "${DOT_DIR}/bin"
_maybe_append_path "${HOME}/.local/bin"
_maybe_append_path "/Applications/Sublime Merge.app/Contents/SharedSupport/bin"
_maybe_append_path "$MY_BIN_LOC"
