-- kitty-navigator.lua - Seamless navigation between vim splits and kitty windows

local M = {}

-- Configuration defaults
M.config = {
  no_mappings = false,
  save_on_switch = false,
  disable_when_zoomed = false,
  preserve_zoom = false,
}

-- Setup function to override defaults
function M.setup(opts)
  M.config = vim.tbl_extend("force", M.config, opts or {})
  
  if not M.config.no_mappings then
    M.setup_mappings()
  end
end

-- Get kitty socket path
local function get_kitty_socket()
  local socket = vim.env.KITTY_LISTEN_ON
  if socket and socket ~= "" then
    return socket
  end
  
  -- Try common unix socket locations
  local socket_paths = {
    "/tmp/mykitty",
    vim.fn.expand("~/.local/state/kitty/kitty.sock"),
  }
  
  for _, path in ipairs(socket_paths) do
    if vim.fn.filereadable(path) == 1 then
      vim.notify("Found kitty socket at: " .. path, vim.log.levels.DEBUG)
      return "unix:" .. path
    end
  end
  
  vim.notify("No kitty socket found!", vim.log.levels.WARN)
  return nil
end

-- Execute kitty command
local function kitty_command(args)
  local socket = get_kitty_socket()
  if not socket then
    vim.notify("Cannot execute kitty command - no socket", vim.log.levels.ERROR)
    return false
  end
  
  local cmd = string.format("kitty @ --to %s %s", vim.fn.shellescape(socket), args)
  local output = vim.fn.system(cmd)
  local success = vim.v.shell_error == 0
  
  if not success then
    vim.notify("Kitty command failed with error: " .. vim.v.shell_error .. "\nOutput: " .. output, vim.log.levels.ERROR)
  end
  
  return success
end

-- Navigate in the given direction
function M.navigate(direction)
  local cur_winnr = vim.fn.winnr()
  
  -- Try vim navigation first
  vim.cmd("wincmd " .. direction)
  
  local new_winnr = vim.fn.winnr()
  
  -- If we changed windows in vim, we're done
  if cur_winnr ~= new_winnr then
    if M.config.save_on_switch then
      -- Save the buffer if it has a name and has been modified
      local bufname = vim.fn.bufname()
      if bufname ~= "" and vim.bo.modified then
        vim.cmd("silent! update")
      end
    end
    return
  end
  
  local kitty_direction = {
    h = "left",
    j = "bottom", 
    k = "top",
    l = "right",
  }
  
  if kitty_direction[direction] then
    kitty_command("focus-window --match neighbor:" .. kitty_direction[direction])
  elseif direction == "p" then
    kitty_command("focus-window --match recent:1")
  end
end

-- Setup key mappings
function M.setup_mappings()
  local opts = { noremap = true, silent = true }
  
  -- Normal mode
  vim.keymap.set('n', '<C-h>', function() M.navigate('h') end, opts)
  vim.keymap.set('n', '<C-j>', function() M.navigate('j') end, opts)
  vim.keymap.set('n', '<C-k>', function() M.navigate('k') end, opts)
  vim.keymap.set('n', '<C-l>', function() M.navigate('l') end, opts)
  vim.keymap.set('n', '<C-\\>', function() M.navigate('p') end, opts)
  
  -- Insert mode
  -- vim.keymap.set('i', '<C-h>', '<Esc><cmd>lua require("kitty-navigator").navigate("h")<cr>', opts)
  -- vim.keymap.set('i', '<C-j>', '<Esc><cmd>lua require("kitty-navigator").navigate("j")<cr>', opts)
  -- vim.keymap.set('i', '<C-k>', '<Esc><cmd>lua require("kitty-navigator").navigate("k")<cr>', opts)
  -- vim.keymap.set('i', '<C-l>', '<Esc><cmd>lua require("kitty-navigator").navigate("l")<cr>', opts)
  vim.keymap.set('i', '<C-\\>', '<Esc><cmd>lua require("kitty-navigator").navigate("p")<cr>', opts)
  
  -- Visual mode
  vim.keymap.set('v', '<C-h>', '<cmd>lua require("kitty-navigator").navigate("h")<cr>', opts)
  vim.keymap.set('v', '<C-j>', '<cmd>lua require("kitty-navigator").navigate("j")<cr>', opts)
  vim.keymap.set('v', '<C-k>', '<cmd>lua require("kitty-navigator").navigate("k")<cr>', opts)
  vim.keymap.set('v', '<C-l>', '<cmd>lua require("kitty-navigator").navigate("l")<cr>', opts)
  vim.keymap.set('v', '<C-\\>', '<cmd>lua require("kitty-navigator").navigate("p")<cr>', opts)
  
  -- Terminal mode
  vim.keymap.set('t', '<C-h>', '<C-\\><C-n><cmd>lua require("kitty-navigator").navigate("h")<cr>', opts)
  vim.keymap.set('t', '<C-j>', '<C-\\><C-n><cmd>lua require("kitty-navigator").navigate("j")<cr>', opts)
  vim.keymap.set('t', '<C-k>', '<C-\\><C-n><cmd>lua require("kitty-navigator").navigate("k")<cr>', opts)
  vim.keymap.set('t', '<C-l>', '<C-\\><C-n><cmd>lua require("kitty-navigator").navigate("l")<cr>', opts)
  vim.keymap.set('t', '<C-\\>', '<C-\\><C-n><cmd>lua require("kitty-navigator").navigate("p")<cr>', opts)
end

-- Create user commands
vim.api.nvim_create_user_command('KittyNavigateLeft', function() M.navigate('h') end, {})
vim.api.nvim_create_user_command('KittyNavigateDown', function() M.navigate('j') end, {})
vim.api.nvim_create_user_command('KittyNavigateUp', function() M.navigate('k') end, {})
vim.api.nvim_create_user_command('KittyNavigateRight', function() M.navigate('l') end, {})
vim.api.nvim_create_user_command('KittyNavigatePrevious', function() M.navigate('p') end, {})

-- Debug command to test kitty connection
vim.api.nvim_create_user_command('KittyDebug', function()
  vim.notify("Testing kitty connection...", vim.log.levels.INFO)
  local socket = get_kitty_socket()
  if socket then
    vim.notify("Socket: " .. socket, vim.log.levels.INFO)
    local success = kitty_command("ls")
    if success then
      vim.notify("Kitty connection successful!", vim.log.levels.INFO)
    else
      vim.notify("Kitty connection failed!", vim.log.levels.ERROR)
    end
  else
    vim.notify("No kitty socket found!", vim.log.levels.ERROR)
  end
end, {})

return M
