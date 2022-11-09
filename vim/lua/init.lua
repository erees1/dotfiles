-- Set leader
vim.api.nvim_set_keymap("n", "<Space>", "<NOP>", { noremap = true, silent = true })
vim.g.mapleader = " "

function nnoremap(keybinding, remap)
	vim.api.nvim_set_keymap("n", keybinding, remap, { noremap = true, silent = true })
end
function vnoremap(keybinding, remap)
	vim.api.nvim_set_keymap("v", keybinding, remap, { noremap = true, silent = true })
end
function inoremap(keybinding, remap)
	vim.api.nvim_set_keymap("i", keybinding, remap, { noremap = true, silent = true })
end
function nmap(keybinding, remap)
	vim.api.nvim_set_keymap("n", keybinding, remap, { noremap = false, silent = true })
end

if require("funcs").is_not_vscode() then
	require("statusline")
	require("settings")
end
-- Packer plugins should use vscode checks
require("plugins")
-- Keybindings need to be compatible with vscode
require("keybindings")

if not require("funcs").is_not_vscode() then
	-- Do this at the end
	require("vscode-keys")
end
