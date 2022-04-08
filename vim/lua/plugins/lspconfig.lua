-- Language servers for lsp
local nvim_lsp = require('lspconfig')
local coq = require('coq')
vim.cmd('let g:coq_settings = { \'keymap.jump_to_mark\' : \'\' }')

nvim_lsp.pyright.setup{
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
        }
      }
    },
}
nvim_lsp.pyright.setup(coq.lsp_ensure_capabilities{})
nvim_lsp.bashls.setup{}

-- Mappings.
local opts = { noremap=true, silent=true }
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
-- See `:help vim.lsp.*` for documentation on any of the below functions
buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspct(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
buf_set_keymap('n', '<CR>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
