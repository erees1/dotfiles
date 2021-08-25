fun! Start()
    " Don't run if: we have commandline arguments, we don't have an empty
    " buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
    if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
        return
    endif

    " Start a new buffer ...
    enew

    " Open fzf
    call fzf#run({'sink': 'e', 'window': {'width': 0.9, 'height': 0.6}})
endfun

" Run after "doing all the startup stuff"
autocmd VimEnter * call Start()
