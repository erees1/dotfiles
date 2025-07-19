" Custom Python syntax highlighting for f-strings
" Override the default green highlighting for f-string interpolations

" Match f-strings and mark the {} parts
syntax region pythonFString start=/\vf"/ end=/"/ contains=pythonFStringBrace
syntax region pythonFString start=/\vf'/ end=/'/ contains=pythonFStringBrace
syntax region pythonFStringBrace start=/{/ end=/}/ contained

" Set highlighting - f-string as string, braces as normal
highlight link pythonFString String
highlight link pythonFStringBrace Normal
