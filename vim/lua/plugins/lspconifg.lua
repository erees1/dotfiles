-- Language servers for lsp
local nvim_lsp = require('lspconfig')

-- signature config
 cfg = {
  hint_prefix = "",  -- Panda for parameter
  hi_parameter = "Search", -- how your parameter will be highlight
  handler_opts = {
    border = "single"   -- double, single, shadow, none
  },
}

require'lspconfig'.pyright.setup{
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off"
        }
      }
    },
    on_attach = function()
      require'lsp_signature'.on_attach(cfg)
    end
}

require'lspconfig'.bashls.setup{}
-- Mappings.
local opts = { noremap=true, silent=true }
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
-- See `:help vim.lsp.*` for documentation on any of the below functions
buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspct(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
buf_set_keymap('n', '<C-n>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', '<C-p>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
