vim.o.termguicolors = true -- Needed for colors

-- vim.wo.number = norelativenumber 
vim.bo.smartindent = true
vim.cmd('set expandtab') -- Converts tabs to spaces
vim.cmd('set ts=2') -- Tabstop
vim.cmd('set sw=2') -- Tabstop

vim.o.clipboard = 'unnamedplus'

vim.o.mouse = 'a' -- Enable mouse in all modes

vim.cmd(':hi NoneText guifg=bg')

vim.highlight.on_yank { higroup='IncSearch', timeout=1000 }
