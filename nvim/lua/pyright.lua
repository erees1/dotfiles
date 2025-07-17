-- Pyright LSP configuration without Mason
local M = {}

function M.setup()

    local on_attach = function(client, bufnr)
        local buf_opts = { buffer = bufnr, silent = true }
        
        -- Keybindings
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, buf_opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, buf_opts)
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, buf_opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, buf_opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, buf_opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, buf_opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, buf_opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, buf_opts)
        vim.keymap.set("n", "<CR>", vim.diagnostic.goto_next, buf_opts)
        vim.keymap.set("n", "do", vim.diagnostic.open_float, buf_opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, buf_opts)
        vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, buf_opts)

        
        vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
        
        -- Diagnostic configuration
        vim.diagnostic.config({
            virtual_text = {
                prefix = "●",
            },
            severity_sort = true,
            float = {
                source = "always",
            },
        })
    end
    
    -- Pyright configuration
    vim.lsp.config("pyright", {
        on_attach = on_attach,
        settings = {
            python = {
                analysis = {
                    autoImportCompletions = true,
                },
            },
        },
    })
    vim.lsp.enable('pyright')

end

return M
