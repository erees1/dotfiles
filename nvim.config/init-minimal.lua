print("Using minimal configuration")

vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.g.mapleader = " "

-- No Plugins configuration
require("settings")
vim.cmd("colorscheme gruvbox")


-- Keybindings need to be compatible with vscode
require("keybindings")
require("vscode_keybindings")