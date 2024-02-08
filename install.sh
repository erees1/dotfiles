#!/bin/bash
set -euo pipefail
SRC_DIR="$(dirname "$0")"
help_message=$(cat <<-END
Usage: [<ENV>=1] ./install.sh 
Install dotfile dependencies on mac or linux

ENV Variables:
    FORCE=1      force reinstall the zsh and tmux plugins
    NO_ROOT=1    install without root permissions
    EXTRA=1      install extra (non crucial binaries, e.g. bat / exa)
END
)

if [[ $# -gt 0 ]]; then
    echo "$help_message"
    exit 1
fi

. $SRC_DIR/utils/logging.sh

install () {
    info "Installing $1"
    "$@"
    success "Finished installing $1"
}

cd "$(dirname $0)"

# Source all the env files in case they set variables needed by the installers
for file in $SRC_DIR/**/*env.zsh; do . $file; done

find . -name install_first.sh -mindepth 2 | while read installer ; do install "${installer}"; done
find . -name install.sh -mindepth 2 | while read installer ; do install "${installer}" ; done
