local function hover_dynamic_size(buf_opts)
  local width = math.min(math.floor(vim.o.columns * 0.8), 100)
  local height = math.min(math.floor(vim.o.lines * 0.3), 30)

  vim.lsp.buf.hover({width=width, height=height})
end

local on_attach = function(client, bufnr)
    local buf_opts = { buffer = bufnr, silent = true }
    
    -- Keybindings
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, buf_opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, buf_opts)
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, buf_opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, buf_opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, buf_opts)
    vim.keymap.set("n", "K", hover_dynamic_size, buf_opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, buf_opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, buf_opts)
    vim.keymap.set("n", "<CR>", vim.diagnostic.goto_next, buf_opts)
    vim.keymap.set("n", "do", vim.diagnostic.open_float, buf_opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, buf_opts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, buf_opts)

    
    -- Diagnostic configuration
    vim.diagnostic.config({
        virtual_text = {
            prefix = "■",
        },
        severity_sort = true,
        float = {
            source = "always",
            border=border
        },
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "■",
                [vim.diagnostic.severity.WARN] = "■",
                [vim.diagnostic.severity.INFO] = "■",
                [vim.diagnostic.severity.HINT] = "■",
            },
            linehl = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
                [vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
                [vim.diagnostic.severity.INFO] = "DiagnosticLineInfo",
                [vim.diagnostic.severity.HINT] = "DiagnosticLineHint",
            },
        },
        underline = true,
        update_in_insert = false,
    })
end

-- Set up diagnostic highlighting
vim.api.nvim_set_hl(0, "DiagnosticLineError", { bg = "#2c1418" })
vim.api.nvim_set_hl(0, "DiagnosticLineWarn", { bg = "#2c2418" })
vim.api.nvim_set_hl(0, "DiagnosticLineInfo", { bg = "#182c24" })
vim.api.nvim_set_hl(0, "DiagnosticLineHint", { bg = "#1c1c2c" })

-- Pyright configuration
vim.lsp.config("pyright", {on_attach = on_attach})
vim.lsp.enable('pyright')

-- Ruff LSP configuration
vim.lsp.config("ruff", {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    on_attach = on_attach,
})
vim.lsp.enable('ruff')

