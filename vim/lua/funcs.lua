local M = {}
function M.is_not_vscode()
    return vim.api.nvim_eval('exists("g:vscode")') == 0
end

function M.reset_bufferline ()
    require('bufferline.state').set_offset(0)
end

return M
