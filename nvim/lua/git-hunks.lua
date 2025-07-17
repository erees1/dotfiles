local M = {}

-- Git diff state
local git_diff_cache = {}
local git_hunk_cache = {}
local git_root = nil

-- Sign definitions
local signs = {
    add = { text = '▎', hl = 'GitHunksAdd' },
    change = { text = '~', hl = 'GitHunksChange' },
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
        local has_add = false
        local has_delete = false
        local first_new_line = new_line
        
        -- First pass: check what types of changes are in this hunk
        for _, line in ipairs(hunk.lines) do
            local first_char = line:sub(1, 1)
            if first_char == '+' then
                has_add = true
            elseif first_char == '-' then
                has_delete = true
            end
        end
        
        -- Determine hunk type
        local hunk_type = 'add'
        if has_add and has_delete then
            hunk_type = 'change'
        elseif has_delete and not has_add then
            hunk_type = 'delete'
        end
        
        -- Second pass: place signs
        for _, line in ipairs(hunk.lines) do
            local first_char = line:sub(1, 1)
            
            if first_char == '+' then
                -- For changes, mark the line
                if hunk_type == 'change' then
                    table.insert(signs_list, { line = new_line, type = 'change' })
                else
                    table.insert(signs_list, { line = new_line, type = 'add' })
                end
                new_line = new_line + 1
            elseif first_char == '-' then
                -- For pure deletes (no adds), show delete marker
                if hunk_type == 'delete' then
                    if first_new_line > 1 then
                        table.insert(signs_list, { line = first_new_line, type = 'delete' })
                    else
                        table.insert(signs_list, { line = 1, type = 'topdelete' })
                    end
                end
                old_line = old_line + 1
            else
                -- Context line
                old_line = old_line + 1
                new_line = new_line + 1
            end
        end
    end
    
    -- Remove duplicates
    local merged_signs = {}
    local seen_lines = {}
    
    for _, sign in ipairs(signs_list) do
        local key = sign.line .. ":" .. sign.type
        if not seen_lines[key] then
            seen_lines[key] = true
            table.insert(merged_signs, sign)
        end
    end
    
    return merged_signs
end

-- Forward declaration
local update_signs

-- Navigate to next hunk
local function next_hunk()
    local bufnr = vim.api.nvim_get_current_buf()
    local hunks = git_hunk_cache[bufnr] or {}
    if #hunks == 0 then return end
    
    local current_line = vim.fn.line('.')
    for _, hunk in ipairs(hunks) do
        if hunk.start_line > current_line then
            vim.api.nvim_win_set_cursor(0, {hunk.start_line, 0})
            return
        end
    end
    -- Wrap to first hunk
    vim.api.nvim_win_set_cursor(0, {hunks[1].start_line, 0})
end

-- Navigate to previous hunk
local function prev_hunk()
    local bufnr = vim.api.nvim_get_current_buf()
    local hunks = git_hunk_cache[bufnr] or {}
    if #hunks == 0 then return end
    
    local current_line = vim.fn.line('.')
    for i = #hunks, 1, -1 do
        if hunks[i].start_line < current_line then
            vim.api.nvim_win_set_cursor(0, {hunks[i].start_line, 0})
            return
        end
    end
    -- Wrap to last hunk
    vim.api.nvim_win_set_cursor(0, {hunks[#hunks].start_line, 0})
end

-- Reset current hunk
local function reset_hunk()
    local bufnr = vim.api.nvim_get_current_buf()
    local filepath = vim.api.nvim_buf_get_name(bufnr)
    if filepath == '' then return end
    
    local relative_path = get_relative_path(filepath)
    if not relative_path then return end
    
    local current_line = vim.fn.line('.')
    
    -- Save buffer if modified
    if vim.bo.modified then
        vim.cmd('write')
    end
    
    -- Get full diff to find the hunk
    local cmd = string.format('cd %s && git diff HEAD -- %s', vim.fn.shellescape(git_root), vim.fn.shellescape(relative_path))
    local handle = io.popen(cmd)
    if not handle then return end
    
    local diff_output = handle:read('*a')
    handle:close()
    
    if diff_output == '' then return end
    
    -- Parse to find the hunk containing current line
    local hunks = parse_diff(diff_output)
    local found_hunk = false
    
    for _, hunk in ipairs(hunks) do
        if current_line >= hunk.new_start and current_line < hunk.new_start + hunk.new_count then
            found_hunk = true
            
            -- Create a patch file with just this hunk
            local patch_content = string.format("--- a/%s\n+++ b/%s\n", relative_path, relative_path)
            patch_content = patch_content .. string.format("@@ -%d,%d +%d,%d @@\n", 
                hunk.old_start, hunk.old_count, hunk.new_start, hunk.new_count)
            
            for _, line in ipairs(hunk.lines) do
                patch_content = patch_content .. line .. "\n"
            end
            
            -- Write patch to temp file
            local temp_patch = os.tmpname()
            local patch_file = io.open(temp_patch, "w")
            if patch_file then
                patch_file:write(patch_content)
                patch_file:close()
                
                -- Apply reverse patch
                local apply_cmd = string.format('cd %s && git apply --reverse %s', 
                    vim.fn.shellescape(git_root), 
                    vim.fn.shellescape(temp_patch))
                
                local result = os.execute(apply_cmd)
                os.remove(temp_patch)
                
                if result == 0 then
                    -- Reload buffer
                    vim.cmd('edit!')
                    
                    -- Update signs
                    vim.defer_fn(function()
                        update_signs(bufnr)
                    end, 50)
                else
                    vim.notify("Failed to reset hunk", vim.log.levels.ERROR)
                end
            end
            
            break
        end
    end
    
    if not found_hunk then
        vim.notify("No git hunk at current line", vim.log.levels.WARN)
    end
end

-- Update signs for a buffer
update_signs = function(bufnr)
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
        git_hunk_cache[bufnr] = {}
        return
    end
    
    -- Parse diff and convert to signs
    local hunks = parse_diff(diff_output)
    local signs_list = hunks_to_signs(hunks)
    
    -- Cache the signs
    git_diff_cache[bufnr] = signs_list
    
    -- Cache hunks with their display line numbers
    local hunk_info = {}
    for _, hunk in ipairs(hunks) do
        local start_line = hunk.new_start
        local end_line = hunk.new_start + hunk.new_count - 1
        
        -- Find the first sign line for this hunk
        local hunk_start_line = nil
        for _, sign in ipairs(signs_list) do
            if sign.line >= start_line and sign.line <= end_line then
                hunk_start_line = sign.line
                break
            end
        end
        
        if hunk_start_line then
            table.insert(hunk_info, {
                start_line = hunk_start_line,
                end_line = end_line,
                new_start = hunk.new_start,
                new_count = hunk.new_count
            })
        end
    end
    git_hunk_cache[bufnr] = hunk_info
    
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
    vim.api.nvim_create_autocmd({'BufWritePost'}, {
        group = group,
        callback = function(args)
            vim.defer_fn(function()
                update_signs(args.buf)
            end, 100)
        end
    })
    -- Update signs autocommand
    vim.api.nvim_create_autocmd({'BufEnter'}, {
        group = group,
        callback = function(args)
            update_signs(args.buf)
        end
    })
    
    -- Initial update for current buffer
    update_signs(vim.api.nvim_get_current_buf())
    
    -- Setup keybindings
    vim.keymap.set('n', '<leader>hn', next_hunk, { desc = 'Go to next git hunk' })
    vim.keymap.set('n', '<leader>hp', prev_hunk, { desc = 'Go to previous git hunk' })
    vim.keymap.set('n', '<leader>hr', reset_hunk, { desc = 'Reset current git hunk' })
end

return M
