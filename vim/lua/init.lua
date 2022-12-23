if require("utils").is_not_vscode() then
	require("components.statusline")
	require("settings")
end
-- Packer plugins should use vscode checks
require("plugins")
-- Keybindings need to be compatible with vscode
require("keybindings")
