local M = {}
function M.is_not_vscode()
	return vim.api.nvim_eval('exists("g:vscode")') == 0
end

function M.reset_bufferline()
	require("bufferline.api").set_offset(0)
end

function M.tree_toggle()
    vim.api.nvim_command('NvimTreeFindFileToggle')
    -- if package.loaded["fugitive"] then
       
    -- end
end
return M
