vim.o.termguicolors = true -- Needed for colors
vim.cmd('colorscheme onebuddy')

vim.bo.smartindent = false
vim.cmd('set expandtab') -- Converts tabs to spaces
vim.o.clipboard = 'unnamedplus'

vim.o.mouse = 'a' -- Enable mouse in all modes
vim.wo.number = true
vim.cmd(':hi NoneText guifg=bg')

vim.api.nvim_command([[
au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=1000 }
]])
