# Only set up homebrew if it's not already in PATH
if ! command -v brew &>/dev/null; then
    typeset -Ug path PATH
    function _maybe_prepend_path() {
        if [ -d "$1" ]; then
            path=("$1" "${path[@]}")
        fi
    }

    # Make homebrew work
    eval "$(/opt/homebrew/bin/brew shellenv)"

    _maybe_prepend_path "/opt/homebrew/sbin"
    _maybe_prepend_path "/opt/homebrew/bin"
fi
