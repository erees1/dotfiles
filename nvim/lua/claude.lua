--- Claude AI code rewriter
--- Simple plugin for inline code rewrites using Claude AI.
---
--- Features:
--- - Rewrite visually selected text with Claude
--- - Insert Claude-generated code at cursor position
--- - Clean, minimal interface
---
--- Requires NVIM_ANTHROPIC_API_KEY environment variable to be set.
---
--- Usage:
--- - `:ClaudeRewrite <prompt>` - Rewrite selected text or current line
--- - `:ClaudeInsert <prompt>` - Insert generated code at cursor

local M = {}
local H = {}

--- Module setup
---
---@param config table|nil Module config table
M.setup = function(config)
  -- Setup config
  config = H.setup_config(config)
  
  -- Apply config
  H.apply_config(config)
end


--- Module config
---
--- Default values:
M.config = {
  -- API settings
  model = 'claude-sonnet-4-20250514',
  max_tokens = 4000,
  
  -- UI settings
  show_progress = true,
  preview_changes = true,
  
  -- Whether to disable showing non-error feedback
  silent = false,
  
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Rewrite selected text (visual mode) - Cmd+i on macOS
    rewrite = '<D-i>',
    
    -- Insert Claude-generated code at cursor (normal mode) - Cmd+i on macOS
    insert = '<D-i>',
  },
}

--- Rewrite selected text or current line
---
---@param prompt string The prompt for rewriting
---@param opts table|nil Options table with 'range' field for visual selection
M.rewrite = function(prompt, opts)
  opts = opts or {}
  
  -- Get text to rewrite
  local lines, start_line, end_line
  if opts.range and opts.range > 0 then
    -- Visual selection - try to get marks, fallback to current line
    start_line = vim.fn.line("'<")
    end_line = vim.fn.line("'>")
    
    -- Check if marks are valid
    if start_line == 0 or end_line == 0 then
      start_line = vim.fn.line('.')
      end_line = start_line
    end
    
    lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  else
    -- Current line
    start_line = vim.fn.line('.')
    end_line = start_line
    lines = vim.api.nvim_buf_get_lines(0, start_line - 1, start_line, false)
  end
  
  M.rewrite_lines(prompt, start_line, end_line)
end

--- Rewrite specific lines
---
---@param prompt string The prompt for rewriting
---@param start_line number Start line number (1-based)
---@param end_line number End line number (1-based, inclusive)
M.rewrite_lines = function(prompt, start_line, end_line)
  -- Get the lines to rewrite
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local original_text = table.concat(lines, '\n')
  
  if original_text == '' then
    H.error('No text to rewrite')
    return
  end
  
  -- Show progress if enabled
  if M.config.show_progress then
    print(string.format('Claude is rewriting lines %d:%d...', start_line, end_line))
  end
  
  -- Call Claude API
  H.call_claude_api(prompt, original_text, function(response)
    if response then
      -- Extract code from backticks
      local code = H.extract_code(response)
      local new_lines = vim.split(code, '\n')
      
      if M.config.preview_changes then
        -- Show preview and ask for confirmation
        H.show_preview(lines, new_lines, function(accepted)
          if accepted then
            vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
            if not M.config.silent then
              print('Claude rewrite accepted')
            end
          else
            if not M.config.silent then
              print('Claude rewrite rejected')
            end
          end
        end)
      else
        -- Apply changes directly
        vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
        if not M.config.silent then
          print('Claude rewrite completed')
        end
      end
    end
  end)
end

--- Insert generated code at cursor
---
---@param prompt string The prompt for code generation
M.insert = function(prompt)
  -- Show progress if enabled
  if M.config.show_progress then
    print('Claude is generating code...')
  end
  
  -- Call Claude API
  H.call_claude_api(prompt, nil, function(response)
    if response then
      -- Extract code from backticks
      local code = H.extract_code(response)
      local new_lines = vim.split(code, '\n')
      
      if M.config.preview_changes then
        -- Show preview and ask for confirmation
        H.show_preview({}, new_lines, function(accepted)
          if accepted then
            local cursor_line = vim.fn.line('.')
            vim.api.nvim_buf_set_lines(0, cursor_line - 1, cursor_line - 1, false, new_lines)
            if not M.config.silent then
              print('Claude code insertion accepted')
            end
          else
            if not M.config.silent then
              print('Claude code insertion rejected')
            end
          end
        end)
      else
        -- Apply changes directly
        local cursor_line = vim.fn.line('.')
        vim.api.nvim_buf_set_lines(0, cursor_line - 1, cursor_line - 1, false, new_lines)
        if not M.config.silent then
          print('Claude code insertion completed')
        end
      end
    end
  end)
end

-- Helper data ================================================================
-- Module default config
H.default_config = vim.deepcopy(M.config)

-- Helper functionality =======================================================
-- Settings -------------------------------------------------------------------
H.setup_config = function(config)
  config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})
  
  -- Validate API key
  if not os.getenv('NVIM_ANTHROPIC_API_KEY') then
    H.error('NVIM_ANTHROPIC_API_KEY environment variable must be set')
  end
  
  -- Validate mappings
  if type(config.mappings) ~= 'table' then
    H.error('mappings must be a table')
  end
  
  return config
end

H.apply_config = function(config)
  M.config = config
  
  -- Create user commands
  vim.api.nvim_create_user_command('ClaudeRewrite', function(cmd)
    if cmd.args == '' then
      H.error('Please provide a prompt for rewriting')
      return
    end
    M.rewrite(cmd.args, { range = cmd.range })
  end, {
    nargs = '+',
    range = true,
    desc = 'Rewrite selected text or current line with Claude',
  })
  
  vim.api.nvim_create_user_command('ClaudeInsert', function(cmd)
    if cmd.args == '' then
      H.error('Please provide a prompt for code generation')
      return
    end
    M.insert(cmd.args)
  end, {
    nargs = '+',
    desc = 'Insert Claude-generated code at cursor',
  })
  
  -- Create mappings
  -- For rewrite: support both normal and visual mode with input prompt
  if config.mappings.rewrite ~= '' then
    -- Normal mode mapping
    local rewrite_normal = function()
      vim.ui.input({ prompt = 'Claude rewrite prompt: ' }, function(input)
        if input and input ~= '' then
          M.rewrite(input)
        end
      end)
    end
    H.map('n', config.mappings.rewrite, rewrite_normal, { desc = 'Claude rewrite' })
    
    -- Visual mode mapping - capture selection before showing prompt
    local rewrite_visual = function()
      -- Get current visual selection using different approach
      -- This works even on first visual selection
      local _, start_line, _, _ = unpack(vim.fn.getpos("'<"))
      local _, end_line, _, _ = unpack(vim.fn.getpos("'>"))
      
      -- If marks are not set (0), fall back to current visual selection
      if start_line == 0 or end_line == 0 then
        -- Use v:start and v:end which are set during visual mode
        start_line = vim.fn.line("v")
        end_line = vim.fn.line(".")
        
        -- Ensure start is before end
        if start_line > end_line then
          start_line, end_line = end_line, start_line
        end
      end
      
      -- Debug logging
      print(string.format("Visual selection captured: start=%d, end=%d", start_line, end_line))
      
      -- Now show the input prompt
      vim.ui.input({ prompt = 'Claude rewrite prompt: ' }, function(input)
        if input and input ~= '' then
          -- Directly use the captured line numbers
          M.rewrite_lines(input, start_line, end_line)
        end
      end)
    end
    H.map('x', config.mappings.rewrite, rewrite_visual, { desc = 'Claude rewrite selection' })
  end
  
  -- For insert: normal mode only with input prompt
  if config.mappings.insert ~= '' then
    local insert_func = function()
      vim.ui.input({ prompt = 'Claude insert prompt: ' }, function(input)
        if input and input ~= '' then
          M.insert(input)
        end
      end)
    end
    H.map('n', config.mappings.insert, insert_func, { desc = 'Claude insert' })
  end
end

-- API calls ------------------------------------------------------------------
H.call_claude_api = function(prompt, original_text, callback)
  local api_key = os.getenv('NVIM_ANTHROPIC_API_KEY')
  if not api_key then
    H.error('NVIM_ANTHROPIC_API_KEY environment variable not set')
    return
  end
  
  -- Build the message content
  local content
  if original_text then
    content = prompt .. '\n\nOriginal code:\n```\n' .. original_text .. '\n```\n\nPlease respond with only the rewritten code in a single code block, no explanations or alternatives.'
  else
    content = prompt .. '\n\nPlease respond with only the code in a single code block, no explanations or alternatives.'
  end
  
  -- Prepare the request payload
  local payload = {
    model = M.config.model,
    max_tokens = M.config.max_tokens,
    messages = {
      {
        role = 'user',
        content = content
      }
    }
  }
  
  -- Convert payload to JSON
  local json_payload = vim.json.encode(payload)
  
  -- Create curl command
  local curl_cmd = {
    'curl',
    '-s',
    '-X', 'POST',
    'https://api.anthropic.com/v1/messages',
    '-H', 'Content-Type: application/json',
    '-H', 'x-api-key: ' .. api_key,
    '-H', 'anthropic-version: 2023-06-01',
    '-d', json_payload
  }
  
  -- Execute curl command asynchronously
  vim.fn.jobstart(curl_cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        local response_text = table.concat(data, '\n')
        if response_text ~= '' then
          -- Parse JSON response
          local ok, response = pcall(vim.json.decode, response_text)
          if ok and response.content and response.content[1] and response.content[1].text then
            callback(response.content[1].text)
          else
            if ok and response.error then
              H.error('Claude API error: ' .. (response.error.message or 'Unknown error'))
            else
              H.error('Failed to parse Claude API response: ' .. response_text)
            end
            callback(nil)
          end
        end
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 0 then
        local error_text = table.concat(data, '\n')
        if error_text ~= '' then
          H.error('Claude API stderr: ' .. error_text)
        end
        callback(nil)
      end
    end,
    on_exit = function(_, code)
      if code ~= 0 then
        H.error('Claude API request failed with exit code: ' .. code)
        callback(nil)
      end
    end
  })
end

-- Utilities ------------------------------------------------------------------
H.error = function(msg)
  vim.notify('(claude) ' .. msg, vim.log.levels.ERROR)
end

H.map = function(mode, lhs, rhs, opts)
  if lhs == '' then return end
  opts = vim.tbl_deep_extend('force', { silent = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

H.extract_code = function(text)
  -- Try to extract code from backticks
  local code_block = text:match('```[%w]*\n(.-)\n```')
  if code_block then
    return code_block
  end
  
  -- Try single backticks
  code_block = text:match('`([^`]+)`')
  if code_block then
    return code_block
  end
  
  -- If no backticks found, return the original text
  return text
end

H.show_preview = function(original_lines, new_lines, callback)
  -- Create preview content
  local preview_content = {}
  
  -- Add header
  table.insert(preview_content, '--- Claude Preview ---')
  table.insert(preview_content, '')
  
  -- Add original (if exists)
  if #original_lines > 0 then
    table.insert(preview_content, '--- Original ---')
    for _, line in ipairs(original_lines) do
      table.insert(preview_content, line)
    end
    table.insert(preview_content, '')
  end
  
  -- Add new content
  table.insert(preview_content, '--- New ---')
  for _, line in ipairs(new_lines) do
    table.insert(preview_content, line)
  end
  table.insert(preview_content, '')
  table.insert(preview_content, 'Press "y" to accept, "n" to reject, or "q" to quit')
  
  -- Create floating window
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, preview_content)
  
  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  
  -- Calculate window size
  local width = math.min(80, vim.o.columns - 4)
  local height = math.min(#preview_content + 2, vim.o.lines - 4)
  
  -- Create floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    border = 'rounded',
    title = 'Claude Preview',
    title_pos = 'center',
  })
  
  -- Set up keymaps for the preview window
  local function close_and_callback(accepted)
    vim.api.nvim_win_close(win, true)
    callback(accepted)
  end
  
  vim.keymap.set('n', 'y', function() close_and_callback(true) end, { buffer = buf })
  vim.keymap.set('n', 'n', function() close_and_callback(false) end, { buffer = buf })
  vim.keymap.set('n', 'q', function() close_and_callback(false) end, { buffer = buf })
  vim.keymap.set('n', '<Esc>', function() close_and_callback(false) end, { buffer = buf })
end

return M
