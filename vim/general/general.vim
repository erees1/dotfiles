
set expandtab
set shiftround  " Round indent to multiple of 'shiftwidth'
set smartindent " Do smart indenting when starting a new line
set autoindent  " Copy indent from current line, over to the new line

" Set the tab width
let s:tabwidth=10
exec 'set tabstop='    .s:tabwidth
exec 'set shiftwidth=' .s:tabwidth
exec 'set softtabstop='.s:tabwidth

:set wrap linebreak nolist


" numbering
set number norelativenumber

let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_events = ["InsertLeave"]

" Copy to cliboard by default
set clipboard+=unnamedplus

:hi NonText guifg=bg

