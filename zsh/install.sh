#!/bin/bash
SRC_DIR=$(dirname "$0")
USAGE=$(cat <<-END
Usage: ./install.sh [OPTION]
Install zsh dependencies on mac or linux

OPTIONS:
    --force      force reinstall the zsh and tmux plugins
END
)

force=false
while (( "$#" )); do
    case "$1" in
        -h|--help)
            echo "$USAGE" && exit 1 ;;
        -f|--force)
            force=true && shift ;;
        --) # end argument parsing
            shift && break ;;
        -*|--*=) # unsupported flags
            echo "Error: Unsupported flag $1" >&2 && exit 1 ;;
    esac
done


# Setting up oh my zsh and oh my zsh plugins
source $SRC_DIR/env.zsh

if [ -d $OH_MY_ZSH ] && [ "$force" = "false" ]; then
    echo "Skipping download of oh-my-zsh and related plugins, pass --force to force redownload"
else
    rm -rf $OH_MY_ZSH
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    rm -f $OH_MY_ZSH/.zshrc.pre-oh-my-zsh  # I don't want t a backup
    ZSH_CUSTOM=$OH_MY_ZSH/custom

    git clone https://github.com/romkatv/powerlevel10k.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k 

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 

    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 

    git clone https://github.com/zsh-users/zsh-completions \
        ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions 

    git clone https://github.com/zsh-users/zsh-history-substring-search \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search 
fi