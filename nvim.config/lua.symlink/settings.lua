
vim.opt.shortmess:append("sI") -- Disable nvim intro
vim.cmd("set noshowmode") -- don't show --INSERT--
vim.o.lazyredraw = true -- Faster scrolling
vim.o.expandtab = true -- Converts tabs to spaces
vim.o.ts = 4 -- Insert 4 spaces for a tab
vim.o.sw = 4 -- Change the number of space characters inserted for indentation
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

-- Autocommands
vim.api.nvim_create_augroup("Misc", { clear = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Filetype autocommands
vim.api.nvim_create_autocmd("FileType", {
    group = "Misc",
    pattern = { "html" },
    callback = function()
        vim.opt_local.sw = 2
        vim.opt_local.ts = 2
    end,
})
