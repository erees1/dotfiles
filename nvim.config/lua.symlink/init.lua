-- Set leader
vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.g.mapleader = " "

-- Vim options
vim.o.termguicolors = true -- Needed for colors

if require("utils").is_not_vscode() then
	require("statusline")
	require("settings")
end
-- Packer plugins should use vscode checks
require("plugins")
-- Keybindings need to be compatible with vscode
require("keybindings")