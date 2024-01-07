-- Set leader
vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.g.mapleader = " "

-- Vim options
vim.o.termguicolors = true -- Needed for colors

require("statusline")
require("settings")

-- Ensure that we have lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugins: lua/plugins/*.lua
require("lazy").setup("plugins")

-- Keybindings need to be compatible with vscode
require("keybindings")

-- Check if the operating system is Linux
local isLinux = (os.execute("uname -s | grep -q Linux") == 0)

-- Require a file if on a Linux machine
if isLinux then require("remote") end
