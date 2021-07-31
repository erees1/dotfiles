set laststatus=2
set statusline=
set statusline+=\ 
set statusline+=%{StatuslineMode()}
set statusline+=\ 
set statusline+=
set statusline+=\ 
set statusline+=%{FugitiveStatusline()}
set statusline+=\ 
set statusline+=%F
set statusline+=%=
set statusline+=%l
set statusline+=/
set statusline+=%L

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  endif
endfunction

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

"function! InsertStatuslineColor(mode)
  "if a:mode == 'i'
    "hi statusline guibg=c.hue_5 ctermfg=6 guifg=Black ctermbg=0
  "elseif a:mode == 'r'
    "hi statusline guibg=c.hue_3 ctermfg=5 guifg=Black ctermbg=0
  "else
    "hi statusline guibg=c.hue_6 ctermfg=1 guifg=Black ctermbg=0
  "endif
"endfunction

"au InsertEnter * call InsertStatuslineColor(v:insertmode)
"au InsertLeave * hi statusline guibg=c.hue_5 ctermfg=8 guifg=White ctermbg=15

" default the statusline to green when entering Vim
"hi statusline guibg=hue_5 ctermfg=8 guifg=White ctermbg=15
