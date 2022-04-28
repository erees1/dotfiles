" Clear default
syn clear pythonStatement

" Set it to what's in the Python file, minus the class.
syn keyword pythonStatement    False True
syn keyword pythonStatement    as assert break continue del exec global
syn keyword pythonStatement    lambda nonlocal pass return with yield
syn keyword pythonStatement    class def nextgroup=pythonFunction skipwhite
syn keyword Function           print
syn keyword Number             None


" Now make seperate syntax groups for the class.
syn keyword pythonClassStmt class nextgroup=pythonClass skipwhite
syn match   pythonClass "\h\w*" display contained
syn match   pythonInstantion /[A-Z]\w\+(/he=e-1
syn match   pythonSelf "\(\W\|^\)\zsself\ze\W"
syn match   pythonDunder /__\w\+__/

" Avoid highlighting attributes as builtins – just added "pythonClass" here.
syn clear pythonAttribute
syn match   pythonAttribute /\.\h\w*/hs=s+1
    \ contains=ALLBUT,pythonBuiltin,pythonFunction,pythonClass,pythonAsync

highlight link pythonClassStmt Statement
highlight link pythonClass TypeDef
highlight link pythonInstantion Type
highlight link pythonSelf Type
highlight link pythonAttribute Function
highlight link pythonDunder Number

function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
