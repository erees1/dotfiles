" Run after "doing all the startup stuff"
if luaeval('require("funcs").is_not_vscode()') 
    fun! Start()
        " Don't run if: we have commandline arguments, we don't have an empty
        " buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
        if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
            return
        endif

        " Start a new buffer ...
        enew

        " Open fzf
        :FzfLua files
    endfun

    autocmd VimEnter * call Start()
else
    echo 'vscode'
endif
