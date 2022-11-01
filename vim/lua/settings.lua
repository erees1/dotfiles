-- Vim options
vim.o.termguicolors = true -- Needed for colors
vim.cmd("colorscheme onedark")

vim.opt.shortmess:append("sI") -- Disable nvim intro
vim.cmd("set noshowmode") -- don't show --INSERT--
vim.o.lazyredraw = true -- Faster scrolling
vim.o.expandtab = true -- Converts tabs to spaces
vim.o.ts = 4 -- Insert 4 spaces for a tab
vim.o.sw = 4 -- Change the number of space characters inserted for indentation
vim.o.smartindent = true
vim.o.autoindent = true
vim.cmd("set formatoptions-=o") -- Don't continue comments when pressing o or O
vim.o.scrolloff = 1000

vim.o.cursorline = true
vim.o.mouse = "a" -- Enable mouse in all modes
vim.wo.number = true
vim.wo.relativenumber = true
vim.cmd(":hi NoneText guifg=bg")

vim.o.ttimeoutlen = 0

-- When searching ignore case of search term unless it has caps
vim.o.smartcase = true
vim.o.ignorecase = true

--Persistent history
vim.o.undodir = "/tmp/.vim-undo-dir"
vim.o.undofile = true

vim.o.fillchars = "diff:/"

-- Use neovim 0.7 filetype.lua for matching filetypes and don't use fallback (for speed)
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

-- Autocommands
vim.api.nvim_create_augroup("Misc", { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank(timeout=1000)",
    group = "Misc",
})

-- Filetype autocommands
vim.api.nvim_create_autocmd("FileType", {
    group = "Misc",
    pattern = { "html", "sh" },
    callback = function()
        vim.opt_local.sw = 2
        vim.opt_local.ts = 2
    end,
})

-- autocmd FileType c,cpp,java setlocal commentstring=//\ %s

-- Config
local M = {}

-- Config options
M.tree_width = 35
M.diff_view_width = 45
M.git_window_width = 50
return M
