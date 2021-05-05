
set background=dark
colorscheme onebuddy

" This function doesn't work when using onebuddy
function! ToggleBackgroundColour ()
    if (&background == 'light')
        set background=dark
    else
        set background=light
    endif
endfunction

nnoremap <silent> <F9> :call ToggleBackgroundColour() <cr>
