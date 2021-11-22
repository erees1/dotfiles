#!/bin/bash
set -euo pipefail
USAGE=$(cat <<-END
    Usage: ./deploy.sh [OPTION]
    Creates ~/.zshrc and ~/.tmux.conf with location
    specific config

    OPTIONS:
        --remote (DEFAULT)      deploy remote config, all aliases are sourced
        --local                 deploy local config, only common aliases are sourced
END
)

export DOT_DIR=$(dirname $(realpath $0))

LOC="remote"
while (( "$#" )); do
    case "$1" in
        -h|--help)
            echo "$USAGE" && exit 1 ;;
        --remote)
            LOC="remote" && shift ;;
        --local)
            LOC="local" && shift ;;
        --) # end argument parsing
            shift && break ;;
        -*|--*=) # unsupported flags
            echo "Error: Unsupported flag $1" >&2 && exit 1 ;;
    esac
done


echo "deploying on $LOC machine..."

# Tmux setup
echo "source $HOME/git/dotfiles/tmux/tmux.conf" > $HOME/.tmux.conf

# Vim / Neovim setup
source "$HOME/git/dotfiles/vim/setup_init.sh"

# zshrc setup
source "$HOME/git/dotfiles/zsh/setup_zshrc.sh"

# Gitconfig setup
source "$HOME/git/dotfiles/gitconf/setup_gitconfig.sh"
    
