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
  if luaeval('require("funcs").is_not_vscode()') 
    let l:head=FugitiveHead()
    if l:head==''
      return l:head
    else
      return " " . l:head . "  "
    endif
  else
    return ""
  endif
endfunction
