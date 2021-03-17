# Regular Vim
echo "source $HOME/git/dotfiles/vim/vimrc.vim" > $HOME/.vimrc
ln -sf $HOME/git/dotfiles/vim/plug-config/coc-settings.json $HOME/.vim


# Neovim
if [ ! -d  $HOME/.config/nvim ]; then
    mkdir -p $HOME/.config/nvim;
fi

# Neovim setup
echo "source $HOME/git/dotfiles/vim/init.vim" > $HOME/.config/nvim/init.vim
ln -sf $HOME/git/dotfiles/vim/plug-config/coc-settings.json $HOME/.config/nvim/coc-settings.json
