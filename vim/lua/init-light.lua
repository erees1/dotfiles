vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.g.mapleader = " "
remap = vim.api.nvim_set_keymap
require("settings")
require("keybindings")
