local M = {}

-- Git diff state
local git_diff_cache = {}
local git_root = nil

-- Sign definitions
local signs = {
    add = { text = '▎', hl = 'GitHunksAdd' },
    change = { text = '▎', hl = 'GitHunksChange' },
    delete = { text = '▸', hl = 'GitHunksDelete' },
    topdelete = { text = '▾', hl = 'GitHunksDelete' },
}

-- Define highlight groups
local function setup_highlights()
    vim.api.nvim_set_hl(0, 'GitHunksAdd', { fg = '#98c379', default = true })
    vim.api.nvim_set_hl(0, 'GitHunksChange', { fg = '#e5c07b', default = true })
    vim.api.nvim_set_hl(0, 'GitHunksDelete', { fg = '#e06c75', default = true })
end

-- Get git root directory
local function get_git_root()
    local handle = io.popen('git rev-parse --show-toplevel 2>/dev/null')
    if handle then
        local result = handle:read('*a'):gsub('\n', '')
        handle:close()
        if result ~= '' then
            return result
        end
    end
    return nil
end

-- Get relative path from git root
local function get_relative_path(filepath)
    if not git_root then return nil end
    local relative = filepath:gsub('^' .. vim.pesc(git_root) .. '/', '')
    return relative
end

-- Parse git diff output
local function parse_diff(diff_output)
    local hunks = {}
    local current_hunk = nil
    
    for line in diff_output:gmatch('[^\r\n]+') do
        -- Parse hunk header: @@ -start,count +start,count @@
        local old_start, old_count, new_start, new_count = line:match('^@@%s+%-(%d+),?(%d*)%s+%+(%d+),?(%d*)%s+@@')
        if old_start then
            current_hunk = {
                old_start = tonumber(old_start),
                old_count = tonumber(old_count) or 1,
                new_start = tonumber(new_start),
                new_count = tonumber(new_count) or 1,
                lines = {}
            }
            table.insert(hunks, current_hunk)
        elseif current_hunk then
            table.insert(current_hunk.lines, line)
        end
    end
    
    return hunks
end

-- Convert hunks to signs
local function hunks_to_signs(hunks)
    local signs_list = {}
    
    for _, hunk in ipairs(hunks) do
        local old_line = hunk.old_start
        local new_line = hunk.new_start
        
        for _, line in ipairs(hunk.lines) do
            local first_char = line:sub(1, 1)
            
            if first_char == '+' then
                -- Added line
                table.insert(signs_list, { line = new_line, type = 'add' })
                new_line = new_line + 1
            elseif first_char == '-' then
                -- Deleted line
                if new_line > 1 then
                    -- Show delete on the line above
                    table.insert(signs_list, { line = new_line - 1, type = 'delete' })
                else
                    -- Top delete
                    table.insert(signs_list, { line = 1, type = 'topdelete' })
                end
                old_line = old_line + 1
            else
                -- Context line
                old_line = old_line + 1
                new_line = new_line + 1
            end
        end
    end
    
    -- Merge consecutive adds/changes
    local merged_signs = {}
    local seen_lines = {}
    
    for _, sign in ipairs(signs_list) do
        if not seen_lines[sign.line] then
            seen_lines[sign.line] = true
            -- Check if this is a modification (has both add and delete nearby)
            local has_delete = false
            for _, s in ipairs(signs_list) do
                if s.type == 'delete' and math.abs(s.line - sign.line) <= 1 then
                    has_delete = true
                    break
                end
            end
            
            if sign.type == 'add' and has_delete then
                sign.type = 'change'
            end
            
            table.insert(merged_signs, sign)
        end
    end
    
    return merged_signs
end

-- Update signs for a buffer
local function update_signs(bufnr)
    local filepath = vim.api.nvim_buf_get_name(bufnr)
    if filepath == '' then return end
    
    local relative_path = get_relative_path(filepath)
    if not relative_path then return end
    
    -- Clear existing signs
    vim.fn.sign_unplace('GitHunks', { buffer = bufnr })
    
    -- Get git diff
    local cmd = string.format('cd %s && git diff -U0 --no-color --no-ext-diff HEAD -- %s', vim.fn.shellescape(git_root), vim.fn.shellescape(relative_path))
    local handle = io.popen(cmd)
    if not handle then return end
    
    local diff_output = handle:read('*a')
    handle:close()
    
    if diff_output == '' then
        git_diff_cache[bufnr] = {}
        return
    end
    
    -- Parse diff and convert to signs
    local hunks = parse_diff(diff_output)
    local signs_list = hunks_to_signs(hunks)
    
    -- Cache the signs
    git_diff_cache[bufnr] = signs_list
    
    -- Place signs
    for _, sign in ipairs(signs_list) do
        local sign_name = 'GitHunks' .. sign.type:gsub("^%l", string.upper)
        vim.fn.sign_place(0, 'GitHunks', sign_name, bufnr, { lnum = sign.line, priority = 10 })
    end
end

-- Setup function
function M.setup()
    -- Get git root
    git_root = get_git_root()
    if not git_root then
        return
    end
    
    -- Setup highlights
    setup_highlights()
    
    -- Define signs
    for name, def in pairs(signs) do
        local sign_name = 'GitHunks' .. name:gsub("^%l", string.upper)
        vim.fn.sign_define(sign_name, {
            text = def.text,
            texthl = def.hl,
            numhl = '',
            linehl = ''
        })
    end
    
    -- Setup autocmds
    local group = vim.api.nvim_create_augroup('GitHunks', { clear = true })
    
    -- Update signs on buffer write
    vim.api.nvim_create_autocmd('BufWritePost', {
        group = group,
        callback = function(args)
            vim.defer_fn(function()
                update_signs(args.buf)
            end, 100)
        end
    })
    
    -- Update signs on buffer enter
    vim.api.nvim_create_autocmd('BufEnter', {
        group = group,
        callback = function(args)
            update_signs(args.buf)
        end
    })
    
    -- Initial update for current buffer
    update_signs(vim.api.nvim_get_current_buf())
end

return M