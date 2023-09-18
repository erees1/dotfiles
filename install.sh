#!/bin/bash
set -euo pipefail
SRC_DIR="$(dirname "$0")"
USAGE=$(cat <<-END
Usage: ./install.sh [OPTION]
Install dotfile dependencies on mac or linux

If OPTIONS are passed they will be installed
with apt if on linux or brew if on OSX

OPTIONS:
    --force      force reinstall the zsh and tmux plugins
    --no-root    install without root permissions
END
)

# parse args
FORCE=false
NO_ROOT=false
while (( "$#" )); do
    case "$1" in
        -h|--help)
            echo "$USAGE" && exit 1 ;;
        -f|--force)
            FORCE=true && shift ;;
        --no-root)
            NO_ROOT=true && shift ;;
        --) # end argument parsing
            shift && break ;;
        -*|--*=) # unsupported flags
            echo "Error: Unsupported flag $1" >&2 && exit 1 ;;
    esac
done

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

install () {
    info "Installing $1"
    "$@"
    success "Finished installing $1"
}

cd "$(dirname $0)"

# Source all the env files in case thy set variables needed by the installers
for file in $SRC_DIR/**/*env.zsh; do . $file; done

if [[ $NO_ROOT == "true" ]]; then
    # find the no root installers and run them iteratively
    find . -name install_no_root.sh -mindepth 2 | while read installer ; do 
        "${installer}"
    done
else
    # find the installers and run them iteratively, pass args recieved
    find . -name install_first.sh | while read installer ; do install "${installer}" ; done

    # find the installers and run them iteratively
    find . -name install.sh -mindepth 2 | while read installer ; do install "${installer}" $([ $FORCE = true ] && echo --force) ; done
fi