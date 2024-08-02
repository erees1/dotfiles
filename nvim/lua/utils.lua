local M = {}
function M.is_not_vscode()
    return vim.api.nvim_eval('exists("g:vscode")') == 0
end
return M
