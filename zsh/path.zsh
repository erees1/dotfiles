typeset -Ug path PATH
function _maybe_prepend_path() {
    if [ -d "$1" ]; then
        path=("$1" "${path[@]}")
    fi
}

_maybe_prepend_path "${DOT_DIR}/bin"
_maybe_prepend_path "${HOME}/.local/bin"
_maybe_prepend_path "/Applications/Sublime Merge.app/Contents/SharedSupport/bin"
_maybe_prepend_path "$MY_BIN_LOC"
