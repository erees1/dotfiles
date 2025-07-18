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
--- - Use configured mapping to rewrite selected text or current line
--- - Use configured mapping to insert generated code at cursor

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
  
  -- Number of lines of context to include before and after selection
  context_lines = 30,
  
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Rewrite selected text (visual mode) - Cmd+i on macOS
    rewrite = '<D-i>',
    
    -- Insert Claude-generated code at cursor (normal mode) - Cmd+i on macOS
    insert = '<D-i>',
  },
}

--- Rewrite selected text or current line
--- No args - prompts for input and detects mode automatically
M.rewrite = function()
  -- Determine if we're in visual mode by checking the mode
  local mode = vim.fn.mode()
  local start_line, end_line
  
  if mode == 'v' or mode == 'V' or mode == '' then
    -- Visual mode - get the actual visual selection
    start_line = vim.fn.line("v")
    end_line = vim.fn.line(".")
    
    -- Ensure start is before end
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
  else
    -- Normal mode - use current line
    start_line = vim.fn.line('.')
    end_line = start_line
  end
  
  -- Get the lines to rewrite
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local original_text = table.concat(lines, '\n')
  
  if original_text == '' then
    H.error('No text to rewrite')
    return
  end
  
  -- Get context around the selection
  local context_data = H.get_context(start_line, end_line)
  
  -- Prompt for input
    vim.ui.input({ prompt = '[' .. start_line .. "->" .. end_line .. "] Claude rewrite prompt: "}, function(prompt)
    if not prompt or prompt == '' then
      return
    end
    
    -- Show progress if enabled
    if M.config.show_progress then
      print(string.format('Claude is rewriting lines %d->%d...', start_line, end_line))
    end
    
    -- Call Claude API with context
    H.call_claude_api_with_context(prompt, original_text, context_data, function(response)
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
  end)
end

--- Insert generated code at cursor
--- No args - prompts for input
M.insert = function()
    -- Prompt for input
    start_line = vim.fn.line(".") 
    vim.ui.input({ prompt = '[' .. start_line .. "] Claude rewrite prompt: "}, function(prompt)
    if not prompt or prompt == '' then
      return
    end
    
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
  
  -- Create mappings
  -- For rewrite: support both normal and visual mode
  if config.mappings.rewrite ~= '' then
    H.map('n', config.mappings.rewrite, M.rewrite, { desc = 'Claude rewrite' })
    H.map('x', config.mappings.rewrite, M.rewrite, { desc = 'Claude rewrite selection' })
  end
  
  -- For insert: normal mode only
  if config.mappings.insert ~= '' then
    H.map('n', config.mappings.insert, M.insert, { desc = 'Claude insert' })
  end
end

-- API calls ------------------------------------------------------------------
H.get_context = function(start_line, end_line)
  local total_lines = vim.api.nvim_buf_line_count(0)
  local context_lines = M.config.context_lines or 30
  
  -- Calculate context boundaries
  local context_start = math.max(1, start_line - context_lines)
  local context_end = math.min(total_lines, end_line + context_lines)
  
  -- Get file path
  local file_path = vim.api.nvim_buf_get_name(0)
  local file_name = file_path ~= '' and vim.fn.fnamemodify(file_path, ':t') or 'buffer'
  
  -- Get context lines
  local before_lines = {}
  local after_lines = {}
  
  if context_start < start_line then
    before_lines = vim.api.nvim_buf_get_lines(0, context_start - 1, start_line - 1, false)
  end
  
  if end_line < context_end then
    after_lines = vim.api.nvim_buf_get_lines(0, end_line, context_end, false)
  end
  
  return {
    file_name = file_name,
    before_lines = before_lines,
    after_lines = after_lines,
    before_count = #before_lines,
    after_count = #after_lines
  }
end

H.call_claude_api_with_context = function(prompt, original_text, context_data, callback)
  local api_key = os.getenv('NVIM_ANTHROPIC_API_KEY')
  if not api_key then
    H.error('NVIM_ANTHROPIC_API_KEY environment variable not set')
    return
  end
  
  -- Build the message content with context
  local content = string.format(
    [[File: %s

[... %d lines of context ...]

%s

<selection_to_modify>
%s
</selection_to_modify>

%s

[... %d lines of context ...]

Task: %s

Please respond with only the rewritten code for the selection in a single code block, no explanations or alternatives.]],
    context_data.file_name,
    context_data.before_count,
    table.concat(context_data.before_lines, '\n'),
    original_text,
    table.concat(context_data.after_lines, '\n'),
    context_data.after_count,
    prompt
  )
  
  H.call_claude_api(content, nil, callback)
end

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
  -- Create two buffers for diff comparison
  local buf_original = vim.api.nvim_create_buf(false, true)
  local buf_new = vim.api.nvim_create_buf(false, true)
  
  -- Set content in buffers
  vim.api.nvim_buf_set_lines(buf_original, 0, -1, false, original_lines)
  vim.api.nvim_buf_set_lines(buf_new, 0, -1, false, new_lines)
  
  -- Set buffer options
  vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf_original })
  vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf_new })
  
  -- Calculate window dimensions
  local width = math.min(80, vim.o.columns - 4)
  local height = math.min(30, math.floor(vim.o.lines * 0.8))
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)
  
  -- Create top floating window (original)
  local win_original = vim.api.nvim_open_win(buf_original, false, {
    relative = 'editor',
    width = width,
    height = math.floor(height / 2) - 1,
    col = col,
    row = row,
    border = 'rounded',
    title = 'Original',
    title_pos = 'center',
  })
  
  -- Create bottom floating window (new)
  local win_new = vim.api.nvim_open_win(buf_new, true, {
    relative = 'editor',
    width = width,
    height = math.floor(height / 2) - 1,
    col = col,
    row = row + math.floor(height / 2) + 1,
    border = 'rounded',
    title = 'Claude Suggestion (y: accept, n: reject, q: quit)',
    title_pos = 'center',
  })
  
  -- Enable diff mode in both windows
  vim.api.nvim_win_call(win_original, function()
    vim.cmd('diffthis')
  end)
  vim.api.nvim_win_call(win_new, function()
    vim.cmd('diffthis')
  end)
  
  -- Function to close both windows and clean up
  local function close_and_callback(accepted)
    -- Disable diff mode before closing
    vim.api.nvim_win_call(win_original, function()
      vim.cmd('diffoff')
    end)
    vim.api.nvim_win_call(win_new, function()
      vim.cmd('diffoff')
    end)
    
    -- Close windows
    vim.api.nvim_win_close(win_original, true)
    vim.api.nvim_win_close(win_new, true)
    
    -- Execute callback
    callback(accepted)
  end
  
  -- Set up keymaps for both windows
  for _, buf in ipairs({buf_original, buf_new}) do
    vim.keymap.set('n', 'y', function() close_and_callback(true) end, { buffer = buf })
    vim.keymap.set('n', 'n', function() close_and_callback(false) end, { buffer = buf })
    vim.keymap.set('n', 'q', function() close_and_callback(false) end, { buffer = buf })
    vim.keymap.set('n', '<Esc>', function() close_and_callback(false) end, { buffer = buf })
  end
end

return M
