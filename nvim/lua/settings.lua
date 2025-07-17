vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.g.mapleader = " "

-- Vim options
vim.o.termguicolors = true -- Needed for colors
vim.cmd("colorscheme darcula")

vim.o.winborder = "rounded"

vim.opt.shortmess:append("sIc") -- Disable nvim intro and completion messages
vim.cmd("set noshowmode") -- don't show --INSERT--
vim.o.lazyredraw = true -- Faster scrolling
vim.o.expandtab = true -- Converts tabs to spaces
vim.o.ts = 4 -- Insert 4 spaces for a tab
vim.o.sw = 4 -- Change the number of space characters inserted for indentation
vim.cmd("set formatoptions-=o") -- Don't continue comments when pressing o or O
vim.o.scrolloff = 8

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
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.updatetime = 50
vim.opt.signcolumn = "yes"

-- Only show cursorline in active window
-- vim.cmd([[
--   augroup CursorLineOnlyInActiveWindow
--     autocmd!
--     autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
--     autocmd WinLeave * if &buftype != 'quickfix' | setlocal nocursorline | endif
--   augroup END
-- ]])

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

-- Triger `autoread` when files changes on disk
-- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
-- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
vim.o.autoread = true
vim.api.nvim_exec([[
  augroup AutoReadGroup
    autocmd!
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~# '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
  augroup END
]], false)

-- Notification after file change
-- https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
vim.api.nvim_exec([[
  augroup NotifyFileChangeGroup
    autocmd!
    autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
  augroup END
]], false)


-- Auto-save when leaving insert mode or changing buffers
vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
    pattern = "*",
    callback = function()
        if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" then
            vim.schedule(function()
                vim.cmd("silent! write")
            end)
        end
    end,
})

-- Add ocp-indent to the runtime path for ocaml files
local home = os.getenv('HOME')
vim.opt.runtimepath:prepend(home .. '/.opam/default/share/ocp-indent/vim')
