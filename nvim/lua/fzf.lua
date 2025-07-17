-- FZF integration without plugins
local function run_fzf_command(command, cleanup_fn, parse_fn)
  local tmpfile = vim.fn.tempname()
  local original_win = vim.api.nvim_get_current_win()
  
  -- Create a new buffer without swapfile
  vim.cmd('noswapfile new')
  local term_buf = vim.api.nvim_get_current_buf()
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.buflisted = false
  
  vim.fn.termopen(command .. ' > ' .. tmpfile, {
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        local ok, selection = pcall(function() return vim.fn.readfile(tmpfile)[1] end)
        if ok and selection and #selection > 0 then
          -- Close the fzf window first
          vim.cmd('close')
          -- Make sure we're in the original window
          vim.api.nvim_set_current_win(original_win)
          
          -- If we have a custom parse function, use it
          if parse_fn then
            parse_fn(selection)
          else
            -- Default behavior - just open the file
            vim.cmd('edit ' .. vim.fn.fnameescape(selection))
          end
        else
          vim.cmd('close')
          vim.api.nvim_set_current_win(original_win)
        end
      else
        -- User cancelled, close fzf window and go back
        vim.cmd('close')
        vim.api.nvim_set_current_win(original_win)
      end
      vim.fn.delete(tmpfile)
      if cleanup_fn then
        cleanup_fn()
      end
    end
  })
  vim.cmd('startinsert')
end

-- FZF files
local function fzf_files()
  run_fzf_command('fzf')
end

-- FZF git files
local function fzf_git_files()
  run_fzf_command('git ls-files | fzf')
end

-- FZF buffers
local function fzf_buffers()
  local tmpfile = vim.fn.tempname()
  local buffers = {}
  for i = 1, vim.fn.bufnr('$') do
    if vim.fn.buflisted(i) == 1 then
      local name = vim.fn.bufname(i)
      if name and name ~= '' then
        table.insert(buffers, name)
      end
    end
  end
  vim.fn.writefile(buffers, tmpfile)
  run_fzf_command('cat ' .. tmpfile .. ' | fzf', function()
    vim.fn.delete(tmpfile)
  end)
end

-- Parse ripgrep output and open file at correct position
local function parse_rg_selection(selection)
  -- Ripgrep format: filename:line:column:matched_text
  local parts = vim.split(selection, ':')
  if #parts >= 3 then
    local filename = parts[1]
    local line = tonumber(parts[2])
    local col = tonumber(parts[3])
    
    -- Open the file
    vim.cmd('edit ' .. vim.fn.fnameescape(filename))
    
    -- Jump to the line and column
    if line then
      vim.api.nvim_win_set_cursor(0, {line, col and col - 1 or 0})
      -- Center the line in the window
      vim.cmd('normal! zz')
    end
  end
end

-- FZF with ripgrep
local function fzf_rg()
  vim.ui.input({ prompt = 'Search: ' }, function(query)
    if query and query ~= '' then
      -- Escape special characters for shell
      query = vim.fn.shellescape(query)
      run_fzf_command(
        'rg --column --line-number --no-heading --color=always --smart-case ' .. query .. ' | fzf --ansi --delimiter : --preview "bat --style=numbers --color=always {1} --highlight-line {2}" --preview-window "right:60%:+{2}-/2"',
        nil,
        parse_rg_selection
      )
    end
  end)
end

-- Alternative: Interactive ripgrep with fzf (live search)
local function fzf_rg_interactive()
  run_fzf_command(
    'true | fzf --phony --bind "change:reload:rg --column --line-number --no-heading --color=always --smart-case {q} || true" --ansi --delimiter : --preview "bat --style=numbers --color=always {1} --highlight-line {2}" --preview-window "right:60%:+{2}-/2"',
    nil,
    parse_rg_selection
  )
end

-- FZF ripgrep for word under cursor
local function fzf_rg_word()
  local word = vim.fn.expand('<cword>')
  if word and word ~= '' then
    local query = vim.fn.shellescape(word)
    run_fzf_command(
      'rg --column --line-number --no-heading --color=always --smart-case ' .. query .. ' | fzf --ansi --delimiter : --preview "bat --style=numbers --color=always {1} --highlight-line {2}" --preview-window "right:60%:+{2}-/2"',
      nil,
      parse_rg_selection
    )
  end
end

-- Key mappings for fzf
vim.keymap.set('n', '<leader>ff', fzf_files, { desc = 'Find files with fzf' })
vim.keymap.set('n', '<leader>fg', fzf_git_files, { desc = 'Find git files with fzf' })
vim.keymap.set('n', '<leader>fb', fzf_buffers, { desc = 'Find buffers with fzf' })
vim.keymap.set('n', '<leader>fr', fzf_rg, { desc = 'Search with ripgrep and fzf' })
vim.keymap.set('n', '<leader>fi', fzf_rg_interactive, { desc = 'Interactive ripgrep search with fzf' })
vim.keymap.set('n', '<leader>fa', fzf_rg_word, { desc = 'Search word under cursor with ripgrep and fzf' })

-- Map Cmd+P to find files (works in terminals that support it)
vim.keymap.set({'n', 'i', 'v'}, '<D-p>', fzf_files, { desc = 'Find files with fzf' })
