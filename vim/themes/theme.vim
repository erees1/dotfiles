source $HOME/git/dotfiles/vim/themes/airline.vim
" source $HOME/git/dotfiles/vim/themes/onedark.vim
" source $HOME/git/dotfiles/vim/themes/summerfruit.vim
source $HOME/git/dotfiles/vim/themes/one.vim

function! ToggleBackgroundColour ()
    if (&background == 'light')
        set background=dark
        echo "background -> dark"
    else
        set background=light
        echo "background -> light"
    endif
endfunction

nnoremap <F9> :call ToggleBackgroundColour() <cr>
