-- Key Mappings
-- Note this is not all key mappings, generally ones specific to a plugin are in the plug-config folder

-- <leader>s to save
vim.keymap.set("n", "<leader>s", ":update<CR>") -- leader s to save

-- Always use g mode which moves through wrapped lines as if they were actual lines
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Shift + HL to move to start and end of visual line
vim.keymap.set("n", "H", "g^")
vim.keymap.set("n", "L", "g$")
vim.keymap.set("v", "H", "g^")
vim.keymap.set("v", "L", "g$")

-- Copy paste from system buffers to make copy paste behaviour more sane
vim.keymap.set("v", "y", '"+y')
vim.keymap.set("v", "x", '"+x')
vim.keymap.set("v", "p", '"+p')
vim.keymap.set("v", "d", '"+d')

vim.keymap.set("n", "y", '"+y')
vim.keymap.set("n", "Y", '"+y$')
vim.keymap.set("n", "x", '"+x')
vim.keymap.set("n", "p", '"+p')
vim.keymap.set("n", "d", '"+d')

-- Quick fix navigation
vim.keymap.set("n", "<M-n>", ":cn<CR>")
vim.keymap.set("n", "<M-p>", ":cp<CR>")

-- <leader><space> to clear highlighing after search
vim.keymap.set("n", "<Leader><space>", ":noh<CR>")

-- I always seem to delete stuff at the bottom of the file with d k so remove
vim.keymap.set("n", "dk", "<Nop>")

-- Keep it centered
vim.keymap.set("n", "n", "nzzzv")

-- Undo these breakpoints when in insert mode
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "(", "(<c-g>u")

-- Only window and reset bufferline to 0 offset
vim.keymap.set("n", "mo", "", {
    callback = function()
        vim.cmd(":wincmd o")
    end,
    noremap = true,
    silent = true,
})

-- Quit with q: instead of bringing up cmd mode
vim.keymap.set("n", "q:", ":q<CR>")

-- Start/end of line with ctrl-b ctrl-e in insert mode
vim.keymap.set("i", "<c-b>", "<c-o>^")
vim.keymap.set("i", "<c-e>", "<c-o>$")

-- Function to yank full path
_G.yank_full_path = function()
    local full_path = vim.fn.expand("%:p") -- Get the full path of the current file
    vim.api.nvim_call_function("setreg", { "+", full_path }) -- Set the clipboard register to the full path
    print("Full path yanked: " .. full_path) -- Notify the user
end

-- Function to yank relative path
_G.yank_relative_path = function()
    local relative_path = vim.fn.expand("%:~:.") -- Get the relative path of the current file
    vim.api.nvim_call_function("setreg", { "+", relative_path }) -- Set the clipboard register to the relative path
    print("Relative path yanked: " .. relative_path) -- Notify the user
end

-- Map the functions to <leader>yr and <leader>yf
vim.keymap.set("n", "<leader>yr", ":lua _G.yank_relative_path()<CR>")
vim.keymap.set("n", "<leader>yf", ":lua _G.yank_full_path()<CR>")

if not require("utils").is_not_vscode() then
    -- Better Navigation
    vim.keymap.set("n", "<C-j>", "<cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>")
    vim.keymap.set("n", "<C-k>", "<cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>")
    vim.keymap.set("n", "<C-h>", "<cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>")
    vim.keymap.set("n", "<C-l>", "<cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>")
    vim.keymap.set("n", "<C-w>_", "<cmd><C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>")

    vim.keymap.set("n", "gr", "<cmd>call VSCodeNotify('editor.action.goToReferences')<CR>")
    vim.keymap.set("n", "<leader>e", "<cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>")
    vim.keymap.set("n", "<leader>t", "<cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")
    vim.keymap.set("n", "<leader>s", "<cmd>call VSCodeNotify('workbench.action.files.save')<CR>")
    vim.keymap.set("n", "<leader>q", "<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>")
    vim.keymap.set("n", "<leader>f", "<cmd>call VSCodeNotify('editor.action.formatDocument')<CR>")
    vim.keymap.set(
        "n",
        "<leader>yr",
        "<cmd>call VSCodeNotify('copyRelativeFilePath')<CR>:echo 'YANKED RELATIVE FILE PATH'<CR>"
    )
    vim.keymap.set("n", "<leader>yf", "<cmd>call VSCodeNotify('copyFilePath')<CR>:echo 'YANKED FILE PATH'<CR>")
    vim.keymap.set("n", "<leader>rn", "<cmd>call VSCodeNotify('editor.action.rename')<CR>")
    vnoremap("<leader>rn", "<cmd>call VSCodeNotify('editor.action.rename')<CR>")

    -- Git navigation
    vim.keymap.set("n", "<leader>hn", "<cmd>call VSCodeNotify('workbench.action.editor.nextChange')<CR>")
    vim.keymap.set("n", "<leader>hp", "<cmd>call VSCodeNotify('git.timeline.openDiff')<CR>")

    -- line indendation
    vim.keymap.set("n", "<S-,>", "<cmd>call VSCodeNotify('editor.action.outdentLines')<CR>")
    vim.keymap.set("n", "<S-.>", "<cmd>call VSCodeNotify('editor.action.indentLines')<CR>")
    vnoremap("<S-,>", "<cmd>call VSCodeNotify('editor.action.outdentLines')<CR>")
    vnoremap("<S-.>", "<cmd>call VSCodeNotify('editor.action.indentLines')<CR>")
end
