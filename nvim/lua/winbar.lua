local M = {}

-- Get the full filepath with modified indicator
M.get_filepath = function()
    -- Check if there's a custom window title set (e.g., by fzf)
    if vim.b.fzf_window_title then
        return '       ' .. vim.b.fzf_window_title
    end
    
    -- Get the relative path from current working directory
    local filepath = vim.fn.fnamemodify(vim.fn.expand('%'), ':.:h')
    local filename = vim.fn.expand('%:t')
    
    if filename == '' then
        return '       [No Name]'
    end
    
    -- Build the full path
    local fullpath
    if filepath == '' or filepath == '.' then
        fullpath = filename
    else
        fullpath = filepath .. '/' .. filename
    end
    
    -- Add modified indicator
    local modified = vim.bo.modified and ' ●' or ''
    
    -- Add spacing at the beginning (2 spaces)
    return '       ' .. fullpath .. modified
end

-- Set up the winbar
M.setup = function()
    -- Create the winbar for each window with statusline highlighting
    vim.opt.winbar = '%#WinBar#%{%v:lua.require("winbar").get_filepath()%}'
end

return M
