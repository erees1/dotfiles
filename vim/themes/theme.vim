" source $HOME/git/dotfiles/vim/themes/airline.vim
source $HOME/git/dotfiles/vim/themes/one.vim

function! ToggleBackgroundColour ()
    if (&background == 'light')
        set background=dark
    else
        set background=light
    endif
endfunction

nnoremap <silent> <F9> :call ToggleBackgroundColour() <cr>
