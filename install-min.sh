export OH_MY_ZSH=$HOME/.oh-my-zsh

brew install coreutils
brew install fzf
brew install bat
brew install git-delta

rm -f $OH_MY_ZSH/.zshrc.pre-oh-my-zsh  # I don't want t a backup
ZSH_CUSTOM=$OH_MY_ZSH/custom

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

rm -rf $ZSH_CUSTOM

git clone https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM}/themes/powerlevel10k 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting 

git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM}/plugins/zsh-autosuggestions 
