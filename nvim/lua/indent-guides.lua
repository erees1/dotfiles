-- Simple indent guides for Neovim
local M = {}

local namespace = vim.api.nvim_create_namespace('indent_guides')

-- Configuration
local config = {
    char = '│',
    highlight = 'IndentGuide',
    enabled = true,  -- Enable by default
}

-- Define highlight
local function setup_highlights()
    vim.api.nvim_set_hl(0, 'IndentGuide', { fg = '#3d3f41', default = true })
end

-- Get indent level for a line
local function get_indent_level(line)
    local indent = line:match('^%s*')
    return #indent
end

-- Update indent guides for a buffer
local function update_indent_guides(bufnr)
    if not config.enabled then
        return
    end
    
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    
    -- Only show for Python filetypes
    local filetype = vim.bo[bufnr].filetype
    if filetype ~= 'python' then
        vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
        return
    end
    
    -- Clear existing virtual text
    vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
    
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local shiftwidth = vim.bo[bufnr].shiftwidth
    if shiftwidth == 0 then shiftwidth = 4 end  -- Default to 4 if not set
    
    -- Calculate indent levels for all lines
    local indent_levels = {}
    for i, line in ipairs(lines) do
        if line:match('%S') then  -- Non-blank line
            indent_levels[i] = math.floor(get_indent_level(line) / shiftwidth)
        else
            indent_levels[i] = nil  -- Mark blank lines
        end
    end
    
    -- Fill in indent levels for blank lines based on surrounding context
    for i = 1, #lines do
        if indent_levels[i] == nil then
            -- Find previous non-blank line
            local prev_level = 0
            for j = i - 1, 1, -1 do
                if indent_levels[j] then
                    prev_level = indent_levels[j]
                    break
                end
            end
            
            -- Find next non-blank line
            local next_level = 0
            for j = i + 1, #lines do
                if indent_levels[j] then
                    next_level = indent_levels[j]
                    break
                end
            end
            
            -- Use the minimum of prev and next to show continuous guides
            indent_levels[i] = math.min(prev_level, next_level)
        end
    end
    
    -- Draw the guides
    for i, line in ipairs(lines) do
        local levels_to_show = indent_levels[i] or 0
        
        for level = 1, levels_to_show do
            local col = (level - 1) * shiftwidth
            
            -- Use virt_text_win_col to position guides at specific columns
            -- This works even on blank lines
            vim.api.nvim_buf_set_extmark(bufnr, namespace, i - 1, 0, {
                virt_text = {{config.char, config.highlight}},
                virt_text_pos = 'inline',
                virt_text_win_col = col,
                priority = 10,
                hl_mode = 'combine',
            })
        end
    end
end

-- Toggle indent guides
function M.toggle()
    config.enabled = not config.enabled
    if config.enabled then
        update_indent_guides()
        vim.notify("Indent guides enabled")
    else
        vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
        vim.notify("Indent guides disabled")
    end
end

-- Setup function
function M.setup(opts)
    -- Merge user options
    if opts then
        config = vim.tbl_extend('force', config, opts)
    end
    
    setup_highlights()
    
    -- Create autocmds
    local group = vim.api.nvim_create_augroup('IndentGuides', { clear = true })
    
    vim.api.nvim_create_autocmd({'BufEnter', 'BufWritePost', 'TextChanged', 'TextChangedI'}, {
        group = group,
        callback = function(args)
            vim.defer_fn(function()
                update_indent_guides(args.buf)
            end, 50)
        end,
    })
    
    -- Initial update
    update_indent_guides()
    
    -- Add toggle command
    vim.api.nvim_create_user_command('IndentGuidesToggle', M.toggle, {})
end













return M
