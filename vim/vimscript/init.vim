if luaeval('require("funcs").is_not_vscode()') 
    source $HOME/git/dotfiles/vim/vimscript/startup.vim
else
    source $HOME/git/dotfiles/vim/vimscript/vscode.vim
endif
