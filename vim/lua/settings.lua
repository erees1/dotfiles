vim.o.termguicolors = true -- Needed for colors
vim.cmd('colorscheme onedark')

vim.bo.smartindent = false
vim.cmd('set expandtab') -- Converts tabs to spaces
vim.cmd('set ts=4') -- Insert 2 spaces for a tab
vim.cmd('set sw=4') -- Change the number of space characters inserted for indentation
vim.o.clipboard = 'unnamedplus'

vim.cmd('set cursorline')
vim.o.mouse = 'a' -- Enable mouse in all modes
vim.wo.number = true
vim.cmd(':hi NoneText guifg=bg')

vim.api.nvim_command([[
au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=1000 }
]])
