-- Simple indent guides for Neovim
local M = {}

local namespace = vim.api.nvim_create_namespace('indent_guides')

-- Configuration
local config = {
    char = '│',
    highlight = 'IndentGuide',
    enabled = false,
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
    
    -- Clear existing virtual text
    vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
    
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local shiftwidth = vim.bo[bufnr].shiftwidth
    
    -- Track indent levels to show continuous guides
    local max_indent = 0
    for _, line in ipairs(lines) do
        if line:match('%S') then  -- Only consider non-blank lines
            local indent = get_indent_level(line)
            max_indent = math.max(max_indent, indent)
        end
    end
    
    for i, line in ipairs(lines) do
        local current_indent = get_indent_level(line)
        local has_content = line:match('%S') ~= nil
        
        -- Show guides up to the maximum indent level seen so far
        -- But only if the current line has enough indentation or is blank
        local guides_to_show = has_content and math.floor(current_indent / shiftwidth) or math.floor(max_indent / shiftwidth)
        
        for level = 1, guides_to_show do
            local col = (level * shiftwidth) - 1
            
            -- Only show guide if it's within the current line's indentation
            -- or if the line is blank (to show continuous guides)
            if col < current_indent or not has_content then
                -- Make sure column is within line bounds
                if col >= 0 and col < #line then
                    vim.api.nvim_buf_set_extmark(bufnr, namespace, i - 1, col, {
                        virt_text = {{config.char, config.highlight}},
                        virt_text_pos = 'overlay',
                        priority = 10,
                    })
                end
            end
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