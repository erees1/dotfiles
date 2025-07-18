" Darcula color scheme for Vim/Neovim
" Based on JetBrains Darcula theme from VSCode

" Initialization
if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='darcula'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" Color Palette - Matched to VSCode Darcula theme
let s:none = ['NONE', 'NONE']
let s:bg = ['#2b2b2b', 235]
let s:bg_light = ['#303030', 236]
let s:bg_lighter = ['#3d3f41', 237]
let s:fg = ['#cccccc', 251]

let s:comment = ['#707070', 242]
let s:string = ['#6A8759', 107]
let s:keyword = ['#CC8242', 172]
let s:function = ['#FFC66D', 221]
let s:number = ['#7A9EC2', 110]
let s:property = ['#9E7BB0', 139]
let s:constant = ['#9E7BB0', 139]
let s:type = ['#7A9EC2', 110]

let s:red = ['#ff6b68', 210]
let s:green = ['#6A8759', 107]
let s:yellow = ['#FFC66D', 221]
let s:orange = ['#CC8242', 172]
let s:blue = ['#7A9EC2', 110]
let s:purple = ['#9E7BB0', 139]
let s:cyan = ['#0c7d9d', 31]

" Selection colors
let s:selection = ['#204182cc', 25]
let s:line_highlight = ['#ffffff0b', 234]

" Helper function
function! s:HL(group, fg, ...)
  let fg = a:fg
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif
  
  if a:0 >= 2 && strlen(a:2)
    let attr = a:2
  else
    let attr = 'NONE'
  endif
  
  let cmd = 'hi ' . a:group
  let cmd .= ' guifg=' . fg[0] . ' ctermfg=' . fg[1]
  let cmd .= ' guibg=' . bg[0] . ' ctermbg=' . bg[1]
  let cmd .= ' gui=' . attr . ' cterm=' . attr
  
  execute cmd
endfunction

" General UI
call s:HL('Normal', s:fg, s:bg)
call s:HL('NormalFloat', s:fg, s:bg_light)
call s:HL('FloatBorder', s:comment, s:bg_light)

" Cursor
call s:HL('Cursor', s:bg, s:fg)
call s:HL('CursorIM', s:bg, s:fg)
call s:HL('CursorLine', s:none, s:bg_lighter)
call s:HL('CursorColumn', s:none, s:bg_lighter)

" UI Elements
call s:HL('LineNr', s:comment, s:none)
call s:HL('CursorLineNr', s:fg, s:bg_lighter)
call s:HL('SignColumn', s:none, s:bg)
call s:HL('VertSplit', ['#3c3f41', 237], s:bg)
call s:HL('TabLine', s:fg, ['#3c3f41', 237])
call s:HL('TabLineFill', s:fg, ['#3c3f41', 237])
call s:HL('TabLineSel', s:fg, ['#2c2c2c', 236])
call s:HL('StatusLine', ['#ffffff', 231], ['#4a4a4a', 239], 'bold')
call s:HL('StatusLineNC', ['#888888', 244], ['#3c3c3c', 237])
call s:HL('Search', s:bg, s:yellow, 'bold')
call s:HL('IncSearch', s:bg, s:yellow, 'bold')
call s:HL('CurSearch', s:bg, s:yellow, 'bold')
call s:HL('Visual', s:bg, s:yellow)
call s:HL('VisualNOS', s:bg, s:yellow)
call s:HL('WildMenu', s:fg, s:selection)
call s:HL('Directory', s:blue, s:none)
call s:HL('ErrorMsg', s:red, s:none)
call s:HL('WarningMsg', s:yellow, s:none)
call s:HL('ModeMsg', s:fg, s:none)
call s:HL('MoreMsg', s:green, s:none)
call s:HL('Question', s:green, s:none)
call s:HL('NonText', s:comment, s:none)
call s:HL('SpecialKey', s:comment, s:none)
call s:HL('Title', s:keyword, s:none, 'bold')
call s:HL('Conceal', s:comment, s:none)
call s:HL('Folded', s:comment, s:bg_light)
call s:HL('FoldColumn', s:comment, s:bg)
call s:HL('MatchParen', s:bg, s:yellow, 'bold')
call s:HL('Paren', s:yellow, s:bg, 'bold')

" Popup Menu
call s:HL('Pmenu', s:fg, s:bg_light)
call s:HL('PmenuSel', ['#cc6e2f', 172], ['#204182cc', 25])
call s:HL('PmenuSbar', s:none, s:bg_light)
call s:HL('PmenuThumb', s:none, s:bg_lighter)

" Syntax Highlighting - Matched to VSCode tokenColors
call s:HL('Comment', s:comment, s:none)
call s:HL('Constant', s:property, s:none)
call s:HL('String', s:string, s:none)
call s:HL('Character', s:string, s:none)
call s:HL('Number', s:number, s:none)
call s:HL('Boolean', s:keyword, s:none)
call s:HL('Float', s:number, s:none)

call s:HL('Identifier', s:fg, s:none)
call s:HL('Function', s:function, s:none)

call s:HL('Statement', s:keyword, s:none)
call s:HL('Conditional', s:keyword, s:none)
call s:HL('Repeat', s:keyword, s:none)
call s:HL('Label', s:keyword, s:none)
call s:HL('Operator', s:fg, s:none)
call s:HL('Keyword', s:keyword, s:none)
call s:HL('Exception', s:keyword, s:none)

call s:HL('PreProc', s:keyword, s:none)
call s:HL('Include', s:keyword, s:none)
call s:HL('Define', s:keyword, s:none)
call s:HL('Macro', s:keyword, s:none)
call s:HL('PreCondit', s:keyword, s:none)

call s:HL('Type', s:type, s:none)
call s:HL('StorageClass', s:keyword, s:none)
call s:HL('Structure', s:keyword, s:none)
call s:HL('Typedef', s:keyword, s:none)

call s:HL('Special', s:keyword, s:none)
call s:HL('SpecialChar', s:keyword, s:none)
call s:HL('Tag', s:function, s:none)
call s:HL('Delimiter', s:fg, s:none)
call s:HL('SpecialComment', s:string, s:none)
call s:HL('Debug', s:red, s:none)

call s:HL('Underlined', s:blue, s:none, 'underline')
call s:HL('Ignore', s:bg, s:none)
call s:HL('Error', s:red, s:none)
call s:HL('Todo', s:keyword, s:none, 'bold')

" Diff - Subtle backgrounds with preserved syntax highlighting
" Added lines: subtle green background, preserve syntax colors
call s:HL('DiffAdd', s:none, ['#2d4a2d', 22])
" Changed lines: lighter grey background, preserve syntax colors
call s:HL('DiffChange', s:none, ['#4a4a4a', 239])
" Deleted lines: subtle grey with hatching
call s:HL('DiffDelete', ['#5a5a5a', 240], ['#3a3a3a', 237])
" Specific changed text: bright orange background, preserve syntax colors
call s:HL('DiffText', s:none, ['#8b5a2b', 208])

" Spell
call s:HL('SpellBad', s:none, s:none, 'undercurl')
call s:HL('SpellCap', s:none, s:none, 'undercurl')
call s:HL('SpellLocal', s:none, s:none, 'undercurl')
call s:HL('SpellRare', s:none, s:none, 'undercurl')

" Language Specific - Python
hi! link pythonBuiltin Type
hi! link pythonFunction Function
hi! link pythonDecorator PreProc
hi! link pythonString String
hi! link pythonRawString String
hi! link pythonException Exception
hi! link pythonExceptions Type

" Language Specific - JavaScript/TypeScript
hi! link javaScriptFunction Function
hi! link javaScriptIdentifier Identifier
hi! link javaScriptMember Property
hi! link javaScriptBraces Delimiter
hi! link typeScriptFunction Function
hi! link typeScriptIdentifier Identifier
hi! link typeScriptBraces Delimiter

" TypeScript specific colors from VSCode theme
call s:HL('typescriptClassName', s:type, s:none)
call s:HL('typescriptClassKeyword', s:keyword, s:none)
call s:HL('typescriptImport', s:keyword, s:none)
call s:HL('typescriptExport', s:keyword, s:none)
call s:HL('typescriptTypeReference', s:type, s:none)

" Language Specific - HTML (matching VSCode)
call s:HL('htmlTag', s:function, s:none)
call s:HL('htmlEndTag', s:function, s:none)
call s:HL('htmlTagName', s:function, s:none)
call s:HL('htmlArg', s:fg, s:none)
call s:HL('htmlString', s:string, s:none)

" Language Specific - CSS
hi! link cssClassName Property
hi! link cssIdentifier Property
hi! link cssBraces Delimiter

" Language Specific - Markdown
call s:HL('markdownH1', s:keyword, s:none, 'bold')
call s:HL('markdownH2', s:keyword, s:none, 'bold')
call s:HL('markdownH3', s:keyword, s:none)
call s:HL('markdownH4', s:keyword, s:none)
hi! link markdownCode String
hi! link markdownCodeBlock String
hi! link markdownURL Underlined

" Object properties (important for matching VSCode)
call s:HL('Property', s:property, s:none)

" Plugin Support - GitGutter/GitSigns
call s:HL('GitGutterAdd', s:green, s:bg)
call s:HL('GitGutterChange', s:yellow, s:bg)
call s:HL('GitGutterDelete', s:red, s:bg)
call s:HL('GitGutterChangeDelete', s:purple, s:bg)

" Plugin Support - Fugitive
hi! link fugitiveHash Identifier
hi! link fugitiveBranch String
hi! link fugitiveRemote Type

" Plugin Support - NERDTree
hi! link NERDTreeDir Directory
hi! link NERDTreeDirSlash Directory
hi! link NERDTreeOpenable Title
hi! link NERDTreeClosable Title
hi! link NERDTreeFile Normal
hi! link NERDTreeExecFile String

" Neovim specific
if has('nvim')
  call s:HL('DiagnosticError', s:red, s:none)
  call s:HL('DiagnosticWarn', s:yellow, s:none)
  call s:HL('DiagnosticInfo', s:blue, s:none)
  call s:HL('DiagnosticHint', s:cyan, s:none)
  
  call s:HL('DiagnosticSignError', s:red, s:bg)
  call s:HL('DiagnosticSignWarn', s:yellow, s:bg)
  call s:HL('DiagnosticSignInfo', s:blue, s:bg)
  call s:HL('DiagnosticSignHint', s:cyan, s:bg)
  
  " LSP
  hi! link LspReferenceText CursorLine
  hi! link LspReferenceRead CursorLine
  hi! link LspReferenceWrite CursorLine
endif

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
