set laststatus=2
set statusline=
set statusline+=\ 
set statusline+=%(%{StatuslineMode()}\ \ %)
set statusline+=%{StatuslineBranch()}
set statusline+=%f
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

function! StatuslineBranch()
  let l:head=FugitiveHead()
  if l:head==''
    return l:head
  else
    return " " . l:head . "  "
endfunction

let NERDTreeStatusline="%{matchstr(getline('.'), '\\s\\zs\\w\\(.*\\)')}"

"Don't show status line in NvimTree
"au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set statusline="%{matchstr(getline('.'), '\\s\\zs\\w\\(.*\\)')}" | else | set laststatus=2 | endif
function! DisableST()
  return "%#StatusLineNC#"
endfunction
au BufEnter NvimTree setlocal statusline=%!DisableST()


""hi User1 ctermfg=14 ctermbg=0 guifg=#93a1a1 guibg=#073642
"function! StatuslineGitBranch()
  "let b:gitbranch=""
  "if &modifiable
    "try
      "let l:dir=expand('%:p:h')
      "let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      "if !v:shell_error
        "let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
      "endif
    "catch
    "endtry
  "endif
"endfunction

"augroup GetGitBranch
  "autocmd!
  "autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
"augroup END

"function! InsertStatuslineColor(mode)
  "if a:mode == 'i'
    "hi link statusline StatusLineInsert
  "elseif a:mode == 'r'
    "hi link statusline StatusLineInsert
  "else
    "hi link statusline StatusLineInsert
  "endif
"endfunction

"au InsertEnter * call InsertStatuslineColor(v:insertmode)
"au InsertLeave * hi link statusline StatusLine 

 ""default the statusline to green when entering Vim
"hi statusline guibg=hue_5 ctermfg=8 guifg=White ctermbg=15

 ""Statusline (requires Powerline font)
"set statusline=
"set statusline+=%(%{&buflisted?bufnr('%'):''}\ \ %)
"set statusline+=%< " Truncate line here
"set statusline+=%f\  " File path, as typed or relative to current directory
"set statusline+=%{&modified?'+\ ':''}
"set statusline+=%{&readonly?'\ ':''}
"set statusline+=%= " Separation point between left and right aligned items
"set statusline+=\ %{&filetype!=#''?&filetype:'none'}
"set statusline+=%(\ %{(&bomb\|\|&fileencoding!~#'^$\\\|utf-8'?'\ '.&fileencoding.(&bomb?'-bom':''):'')
  "\.(&fileformat!=#(has('win32')?'dos':'unix')?'\ '.&fileformat:'')}%)
"set statusline+=%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)
"set statusline+=\ 
"set statusline+=\ %{&number?'':printf('%2d,',line('.'))} " Line number
"set statusline+=%-2v " Virtual column number
"set statusline+=\ %2p%% " Percentage through file in lines as in |CTRL-G|

"" ------------------------ 8< ------------------------

"" Statusline with highlight groups (requires Powerline font, using Solarized theme)
"set statusline=
"set statusline+=%(%{&buflisted?bufnr('%'):''}\ \ %)
"set statusline+=%< " Truncate line here
"set statusline+=%f\  " File path, as typed or relative to current directory
"set statusline+=%{&modified?'+\ ':''}
"set statusline+=%{&readonly?'\ ':''}
"set statusline+=%1*\  " Set highlight group to User1
"set statusline+=%= " Separation point between left and right aligned items
"set statusline+=\ %{&filetype!=#''?&filetype:'none'}
"set statusline+=%(\ %{(&bomb\|\|&fileencoding!~#'^$\\\|utf-8'?'\ '.&fileencoding.(&bomb?'-bom':''):'')
  "\.(&fileformat!=#(has('win32')?'dos':'unix')?'\ '.&fileformat:'')}%)
"set statusline+=%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)
"set statusline+=\ %* " Restore normal highlight
"set statusline+=\ %{&number?'':printf('%2d,',line('.'))} " Line number
"set statusline+=%-2v " Virtual column number
"set statusline+=\ %2p%% " Percentage through file in lines as in |CTRL-G|

"" Logic for customizing the User1 highlight group is the following
"" - if StatusLine colors are reverse, then User1 is not reverse and User1 fg = StatusLine fg
""hi StatusLine cterm=reverse gui=reverse ctermfg=14 ctermbg=8 guifg=#93a1a1 guibg=#002732
""hi StatusLineNC cterm=reverse gui=reverse ctermfg=11 ctermbg=0 guifg=#657b83 guibg=#073642
""hi User1 ctermfg=14 ctermbg=0 guifg=#93a1a1 guibg=#073642
