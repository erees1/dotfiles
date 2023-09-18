-- Language servers for lsp
require("mason").setup()
require("mason-lspconfig").setup()
local nvim_lsp = require("lspconfig")

require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "pyright" , "bashls", "clangd", "html"},
}

-- Mappings.
local opts = { noremap = true, silent = true }

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gf", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "gh", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspct(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "<CR>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({async = True})<CR>", opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
nvim_lsp.pyright.setup({
    capabilities = capabilities,
    on_attch = on_attach,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off",
            },
        },
    },
})

nvim_lsp.bashls.setup({
    on_attach = on_attach,
})

-- require("null-ls").setup({
--     on_attach = on_attach,
--     sources = {
--         require("null-ls").builtins.formatting.stylua,
--         require("null-ls").builtins.diagnostics.flake8.with({
--             extra_args = { "--max-line-length=120", "--ignore=E203,W503,E712" },
--         }),
--         require("null-ls").builtins.formatting.black,
--     },
-- })

nvim_lsp.clangd.setup({
    on_attch = on_attach,
})
nvim_lsp.html.setup({
    on_attach = on_attach,
    provideFormatter = true,
})
