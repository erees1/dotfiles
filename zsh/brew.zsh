# Only set up homebrew if it's not already in PATH
if ! command -v brew &>/dev/null; then
    typeset -Ug path PATH

    # Define _maybe_prepend_path if it doesn't already exist
    if ! typeset -f _maybe_prepend_path &>/dev/null; then
        function _maybe_prepend_path() {
            if [ -d "$1" ]; then
                path=("$1" "${path[@]}")
            fi
        }
    fi

    # Make homebrew work
    eval "$(/opt/homebrew/bin/brew shellenv)"

    _maybe_prepend_path "/opt/homebrew/sbin"
    _maybe_prepend_path "/opt/homebrew/bin"
fi
