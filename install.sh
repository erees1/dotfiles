#!/bin/bash
set -euo pipefail
USAGE=$(cat <<-END
Usage: ./install.sh [OPTION]
Install dotfile dependencies on mac or linux

If OPTIONS are passed they will be installed
with apt if on linux or brew if on OSX

OPTIONS:
    --tmux       install tmux
    --zsh        install zsh 
    --delta      install delta (nicer git diff)
    --nvim       install nvim
    --fzf        install fzf
    --exa        install exa (nicer ls)
END
)

operating_system="$(uname -s)"
case "${operating_system}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${operating_system}"
esac


# There are some extra options for mac
if [ $machine == "Mac" ]; then
    USAGE+=$(cat <<-END

    --pyenv      install pyenv
END
)
fi

zsh=false
tmux=false
delta=false
nvim=false
pyenv=false
fzf=false
exa=false
force=false
while (( "$#" )); do
    case "$1" in
        -h|--help)
            echo "$USAGE" && exit 1 ;;
        --zsh)
            zsh=true && shift ;;
        --tmux)
            tmux=true && shift ;;
        --delta)
            delta=true && shift ;;
        --nvim)
            nvim=true && shift ;;
        --pyenv)
            pyenv=true && shift ;;
        --fzf)
            fzf=true && shift ;;
        --exa)
            exa=true && shift ;;
        -f|--force)
            force=true && shift ;;
        --) # end argument parsing
            shift && break ;;
        -*|--*=) # unsupported flags
            echo "Error: Unsupported flag $1" >&2 && exit 1 ;;
    esac
done

echo " ------------ INSTALLING ON $machine MACHINE ------------ "
# Installing on linux with apt
if [ $machine == "Linux" ]; then
    DOT_DIR=$(dirname $(realpath $0))
    [ $zsh == true ] && sudo apt-get install zsh
    [ $tmux == true ] && sudo apt-get install tmux 
    [ $delta == true ] && $DOT_DIR/install_scripts/install_delta.sh
    [ $nvim == true ] && $DOT_DIR/install_scripts/install_nvim.sh "release"
    [ $exa == true ] && $DOT_DIR/install_scripts/install_exa.sh
    if [ $fzf == true ]; then
        rm -rf $HOME/.fzf
        git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
        $HOME/.fzf/install
    fi
    # Installing on mac with homebrew
elif [ $machine == "Mac" ]; then
    brew install coreutils  # Mac won't have realpath before coreutils installed
    DOT_DIR=$(dirname $(realpath $0))
    [ $zsh == true ] && brew install zsh
    [ $tmux == true ] && brew install tmux
    [ $delta == true ] && brew install git-delta
    if [ $nvim == true ]; then 
        brew install neovim
        # Node is used to install language servers in vim/setup_init.sh
        brew install node
    fi
    [ $exa == true ] && brew install exa
    if [ $pyenv == true ]; then
        brew install pyenv
        brew install pyenv-virtualenv
    fi
    if [ $fzf == true ]; then
        brew install fzf
        $(brew --prefix)/opt/fzf/install
    fi
fi

echo " --------- INSTALLING DEPENDENCIES ⏳ ----------- "
# Setting up oh my zsh and oh my zsh plugins
ZSH=~/.oh-my-zsh
ZSH_CUSTOM=$ZSH/custom
if [ -d $ZSH ] && [ "$force" = "false" ]; then
    echo "Skipping download of oh-my-zsh and related plugins, pass --force to force redeownload"
else
    rm -rf $ZSH
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    rm -f $HOME/.zshrc.pre-oh-my-zsh  # I don't want t a backup

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
if [ -d $HOME/.tmux/plugins/tpm ] && [ "$force" = "false" ]; then
    rm -rf $HOME/.tmux/plugins/tpm
    echo "Skipping download of tmux plugin manager, pass --force to force redeownload"
else
    # Tmux plugin manager
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
echo " --------- INSTALLED SUCCESSFULLY ✅ ----------- "
