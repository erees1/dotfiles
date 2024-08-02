return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            completion = {
                keyword_length = 3,     -- Min word length before showing result
                completeopt = "menu,menuone,noinsert",
            },
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)     -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-l>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),     -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "nvim_lsp_signature_help" },
            }),
        })
    end,
    cond = { require("utils").is_not_vscode },
}
