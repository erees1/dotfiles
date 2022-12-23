#!/bin/bash
set -euo pipefail
USAGE=$(cat <<-END
Usage: ./deploy.sh [OPTION]
Creates ~/.zshrc and ~/.tmux.conf with location
specific config

OPTIONS:
    --local                 deploy local config, only common aliases are sourced
END
)

export DOT_DIR=$(dirname $(realpath $0))

LOC="remote"
while (( "$#" )); do
    case "$1" in
        -h|--help)
            echo "$USAGE" && exit 1 ;;
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

# Vim / Neovim setup
source "$DOT_DIR/vim/setup_init.sh"

# zshrc setup
echo "source $DOT_DIR/zsh/$LOC/zshrc.sh" > $HOME/.zshrc

# Gitconfig setup
source "$DOT_DIR/gitconf/setup_gitconfig.sh"

echo "c.TerminalInteractiveShell.editing_mode = 'vi'" > ~/.ipython/profile_default/ipython_config.py
echo "c.TerminalInteractiveShell.emacs_bindings_in_vi_insert_mode = False" >> ~/.ipython/profile_default/ipython_config.py
echo "c.TerminalInteractiveShell.timeoutlen = 0.01" >> ~/.ipython/profile_default/ipython_config.py

cat "$DOT_DIR/config/keybindings.py" > $HOME/.ipython/profile_default/startup/keybindings.py

if [ $LOC == 'local' ]; then
    # Karabiner elements mapping
    mkdir -p $HOME/.config/karabiner
    karabiner_path=$HOME/.config/karabiner/karabiner.json
    dd_karabiner_path=$DOT_DIR/config/karabiner.json

    if ! cmp -s $karabiner_path $dd_karabiner_path; then
        read -p "karabiner.json differs from dotfiles v do you want to overwrite? (y/n) " yn
        case $yn in 
            y )
                cat $karabiner_path > $karabiner_path.backup
                ln -sf "$DOT_DIR/config/karabiner.json" "$karabiner_path" ;
                ;;
            n ) echo skipping...;
                exit;;
        esac
    else
        ln -sf "$DOT_DIR/config/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
    fi

    mkdir -p $HOME/.ssh
    ln -sf "$DOT_DIR/config/ssh_config" "$HOME/.ssh/config"

    # By default when you hold a key on mac it brings up the accents menu
    # This means you can't hold vim keys in vscode so disable it
    defaults write -g ApplePressAndHoldEnabled -bool false  
fi
# Relaunch zsh
zsh
