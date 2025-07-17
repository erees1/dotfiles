-- Minimal LSP setup without plugin managers
-- This can be required from your init.lua: require('minimal')

local M = {}

function M.setup()
    -- Check if nvim-lspconfig is available
    local ok, lspconfig = pcall(require, 'lspconfig')
    if not ok then
        print("nvim-lspconfig not found. Please install it manually:")
        print("git clone https://github.com/neovim/nvim-lspconfig ~/.config/nvim/pack/nvim-lspconfig/start/nvim-lspconfig")
        return
    end
end

-- Auto-setup if this file is required directly
if vim.fn.expand('%:t') == 'init.lua' then
    M.setup()
end

return M
