" Run after "doing all the startup stuff"
if luaeval('require("funcs").is_not_vscode()')
    fun! Start()
        " Don't run if: we have commandline arguments, we don't have an empty
        " buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
        if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
            return
        endif

        " Start a new buffer ...
        "enew

        " Open fzf
        if luaeval('require("settings").fzf_on_startup')
            :FzfLua files
        endif
        if luaeval('require("settings").open_tree_on_startup')
            "Statusline doesn't seem to work on startup 
            setlocal statusline=%!v:lua.Statusline('inactive')
            :lua _tree_toggle()
            setlocal statusline=%!v:lua.Statusline('explorer')
        endif
    endfun

    autocmd VimEnter * call Start()
else
    echo 'vscode'
endif
