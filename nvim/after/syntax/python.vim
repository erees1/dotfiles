" Custom Python syntax highlighting for f-strings
" Override the default green highlighting for f-string interpolations

" Match f-strings and mark the {} parts
syntax region pythonFString start=/\vf"/ end=/"/ contains=pythonFStringBrace
syntax region pythonFString start=/\vf'/ end=/'/ contains=pythonFStringBrace
syntax region pythonFStringBrace start=/{/ end=/}/ contained

" Set highlighting - f-string as string, braces as normal
highlight link pythonFString String
highlight link pythonFStringBrace Normal

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
syn match   pythonInstantiation /\(\W\|^\)\zs[A-Z]\w\+\ze(/
syn match   pythonInstantiation /\(\W\|^\)\zs[A-Z]\w\+\ze\./
syn match   pythonSelf "\(\W\|^\)\zsself\ze\W"
syn match   pythonDunder /__\w\+__/
syn match   pythonConstant "\(\s\|^\)[A-Z_0-9]\+[A-Z_0-9]*[A-Z_0-9]\+\(\s\|$\)"

" Avoid highlighting attributes as builtins – just added "pythonClass" here.
syn clear pythonAttribute
syn match   pythonAttribute /\.\h\w*/hs=s+1
    \ contains=ALLBUT,pythonBuiltin,pythonFunction,pythonClass,pythonAsync

highlight link pythonClassStmt Statement
highlight link pythonClass TypeDef
highlight link pythonConstant Constant
highlight link pythonInstantiation Type
highlight link pythonSelf Type
highlight link pythonAttribute Function
highlight link pythonDunder Number

function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
