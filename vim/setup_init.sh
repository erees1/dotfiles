# Neovim
if [ ! -d  $HOME/.config/nvim ]; then
    mkdir -p $HOME/.config/nvim;
fi

# Neovim setup
echo "require('init')" > $HOME/.config/nvim/init.lua

if [ $LOC == "remote" ] ; then
  echo "require('remote')" >> $HOME/.config/nvim/init.lua
fi

ln -sf $HOME/git/dotfiles/vim/lua $HOME/.config/nvim
ln -sf $HOME/git/dotfiles/vim/plug-config/coc-settings.json $HOME/.config/nvim/coc-settings.json
