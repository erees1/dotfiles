local M = {}
function M.is_not_vscode()
	return vim.api.nvim_eval('exists("g:vscode")') == 0
end

function M.reset_bufferline()
	require("bufferline.api").set_offset(0)
end

function M.tree_toggle()
    vim.api.nvim_command('NvimTreeFindFileToggle')
end

-- Config options
M.tree_width = 35
M.diff_view_width = 45
M.git_window_width = 50

return M
