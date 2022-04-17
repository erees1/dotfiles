-- Config
local M = {}

-- Config options
M.tree_width = 35
M.diff_view_width = 45
M.fzf_on_startup = false
M.open_tree_on_startup = false
M.git_window_width = 50

-- Vim options
vim.o.termguicolors = true -- Needed for colors
vim.cmd('colorscheme onedark')

vim.cmd('set shm+=I') -- don't show intro screen
vim.cmd('set noshowmode') -- don't show --INSERT--

vim.cmd('set expandtab') -- Converts tabs to spaces
vim.cmd('set ts=4') -- Insert 2 spaces for a tab
vim.cmd('set sw=4') -- Change the number of space characters inserted for indentation
vim.cmd('set smartindent')
vim.cmd('set autoindent')
vim.cmd('set formatoptions-=o') -- Don't continue comments when pressing o or O

vim.cmd('set cursorline')
vim.o.mouse = 'a' -- Enable mouse in all modes
vim.wo.number = true
vim.wo.relativenumber = true
vim.cmd(':hi NoneText guifg=bg')

vim.cmd('set ttimeoutlen=0')

-- When searching ignore case of search term unless it has caps
vim.cmd('set smartcase')
vim.cmd('set ignorecase')

--Persistent history
vim.cmd('set undodir=/tmp/.vim-undo-dir')
vim.cmd('set undofile')

vim.cmd('set fillchars=diff:/')

vim.api.nvim_command([[
au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=1000 }
]])

-- Use neovim 0.7 filetype.lua for matching filetypes and don't use fallback (for speed)
vim.g.do_filetype_lua = 1  
vim.g.did_load_filetypes = 0

return M
