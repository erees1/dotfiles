vim.o.termguicolors = true -- Needed for colors
vim.cmd('colorscheme onedark')

vim.cmd('set shm+=I') -- don't show intro screen
vim.cmd('set noshowmode') -- don't show --INSERT--

vim.bo.smartindent = false
vim.cmd('set expandtab') -- Converts tabs to spaces
vim.cmd('set ts=4') -- Insert 2 spaces for a tab
vim.cmd('set sw=4') -- Change the number of space characters inserted for indentation
vim.cmd('set nofixendofline')

vim.cmd('set cursorline')
vim.o.mouse = 'a' -- Enable mouse in all modes
vim.wo.number = true
vim.cmd(':hi NoneText guifg=bg')

--Persistent history
vim.cmd('set undodir=/tmp/.vim-undo-dir')
vim.cmd('set undofile')

tree_width = 35

vim.api.nvim_command([[
au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=1000 }
]])
