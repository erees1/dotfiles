-- Language servers for lsp
return {
    -- LSP Completion
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        cond = { require("utils").is_not_vscode },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "jose-elias-alvarez/null-ls.nvim" },
        cond = { require("utils").is_not_vscode },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "bashls", "clangd", "html", "rust_analyzer" },
            })

            local nvim_lsp = require("lspconfig")

            -- Mappings.
            local on_attach = function(client, bufnr)
                local buf_opts = { buffer = bufnr, silent = true }
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, buf_opts)
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, buf_opts)
                vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end, buf_opts)
                vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, buf_opts)
                vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, buf_opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, buf_opts)
                vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, buf_opts)
                vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, buf_opts)
                vim.keymap.set("n", "<CR>", function() vim.diagnostic.goto_next() end, buf_opts)
                vim.keymap.set("n", "do", function() vim.diagnostic.open_float() end, buf_opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, buf_opts)
                vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, buf_opts)

                vim.diagnostic.config({
                    virtual_text = {
                        -- source = "always",  -- Or "if_many"
                        prefix = "●", -- Could be '■', '▎', 'x'
                    },
                    severity_sort = true,
                    float = {
                        source = "always", -- Or "if_many"
                    },
                })
            end

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            nvim_lsp.pyright.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "on",
                        },
                    },
                },
            })

            nvim_lsp.bashls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            nvim_lsp.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim", "hs" },
                        },
                    },
                },
            })
            nvim_lsp.clangd.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = {
                    "clangd",
                    "--offset-encoding=utf-16",
                },
            })
            nvim_lsp.html.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                provideFormatter = true,
            })

            -- Formatters

            local null_ls = require("null-ls")

            null_ls.setup({
                on_attach = on_attach,
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.black,
                },
            })
        end,
    },
}
