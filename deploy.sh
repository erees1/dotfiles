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
echo "source $DOT_DIR/tmux/tmux.conf" > $HOME/.tmux.conf
source $DOT_DIR/custom_bins/deploy_bins.sh

# Vim / Neovim setup
source "$DOT_DIR/vim/setup_init.sh"

# zshrc setup
source "$DOT_DIR/zsh/setup_zshrc.sh"

# Gitconfig setup
source "$DOT_DIR/gitconf/setup_gitconfig.sh"

# Karabiner elements mapping
if [ $LOC == 'local' ]; then
    ln -sf "$DOT_DIR/config/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
fi
# Relaunch zsh
zsh
