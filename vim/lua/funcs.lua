local M = {}
function M.is_not_vscode()
	return vim.api.nvim_eval('exists("g:vscode")') == 0
end

function M.reset_bufferline()
	require("bufferline.state").set_offset(0)
end


function M.tree_close()
    require("bufferline.state").set_offset(0)
    if require("nvim-tree.view").is_visible() then
        require("nvim-tree").toggle()
    end
end

function M.tree_open()
    require("bufferline.state").set_offset(require("settings").tree_width + 1, "FileTree")
    require("nvim-tree").open()
end

function M.tree_toggle()
    if require("nvim-tree.view").is_visible() then
        M.tree_close()
    else
        M.tree_open()
    end
end

return M
