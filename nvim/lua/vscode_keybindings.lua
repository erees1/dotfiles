if not require("utils").is_not_vscode() then
    print("Using vscode keybindings")
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
    vim.keymap.set("v", "<leader>rn", "<cmd>call VSCodeNotify('editor.action.rename')<CR>")

    -- Git navigation
    vim.keymap.set("n", "<leader>hn", "<cmd>call VSCodeNotify('workbench.action.editor.nextChange')<CR>")
    vim.keymap.set("n", "<leader>hp", "<cmd>call VSCodeNotify('git.timeline.openDiff')<CR>")

    -- line indendation
    vim.keymap.set("n", "<S-,>", "<cmd>call VSCodeNotify('editor.action.outdentLines')<CR>")
    vim.keymap.set("n", "<S-.>", "<cmd>call VSCodeNotify('editor.action.indentLines')<CR>")
    vim.keymap.set("v", "<S-,>", "<cmd>call VSCodeNotify('editor.action.outdentLines')<CR>")
    vim.keymap.set("v", "<S-.>", "<cmd>call VSCodeNotify('editor.action.indentLines')<CR>")
end