return {
  {
    "tpope/vim-fugitive",
    cond = { require("utils").is_not_vscode },
    keys = { "gs", "<leader>ds" },
    cmd = { "Git", "G" },
    config = function()
      function M.VertGStatus()
        if package.loaded["nvim-tree"] then
          require("nvim-tree.view").close()
        end
        s = 50, 
        vim.cmd("vert Git")
        cmd = string.format("vert resize %s", s)
        vim.cmd(cmd)
      end

      function M.GClose()
        vim.cmd("normal gq")
      end

      function M.GDiffOpen()
        local cur_win = vim.api.nvim_get_current_win()
        vim.cmd("normal dv")
        vim.api.nvim_set_current_win(cur_win)
      end

      vim.cmd([[
    augroup fugitive_au
      autocmd!
      autocmd FileType fugitive setlocal winfixwidth
      autocmd FileType fugitive setlocal nobuflisted
      autocmd FileType fugitive setlocal nonumber | setlocal norelativenumber
      autocmd FileType fugitive setlocal winhighlight=Normal:DiffViewNormal,WinSeparator:DiffviewVertSplit,EndOfBuffer:DiffviewEndOfBuffer,SignColumn:DiffViewNormal
      autocmd FileType fugitive nnoremap <buffer> gs <cmd>lua require('plugins.fugitive').GClose()<CR>
      autocmd FileType fugitive nnoremap <buffer> dd <cmd>lua require('plugins.fugitive').GDiffOpen()<CR>
      autocmd FileType gitcommit wincmd J
      autocmd BufReadPost fugitive://* set bufhidden=delete
    augroup END
    ]])

      vim.keymap.set("n", "gs", ":Git|20wincmd_<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>ds", ":Gvdiffsplit!<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>mh", ":diffget //2<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>ml", ":diffget //3<CR>", { noremap = true, silent = true })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    cond = { require("utils").is_not_vscode },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
          change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
          delete = { hl = "GitSignsDelete", text = "|", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          topdelete = { hl = "GitSignsDelete", text = "|", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
          changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        },
        numhl = false,
        linehl = false,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', '<leader>hn', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '<leader>hp', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk)
          map('n', '<leader>hr', gs.reset_hunk)
          map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hd', gs.preview_hunk)
          map('n', '<leader>hb', function() gs.blame_line { full = true } end)
          map('n', '<leader>hD', function() gs.diffthis('~') end)

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end,
        watch_gitdir = {
          interval = 1000,
        },
        current_line_blame = false,
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        --diff_opts.internal = true,  -- If luajit is present
      })
    end,
  }
}
