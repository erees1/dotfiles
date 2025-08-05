-- Key Mappings
-- Note this is not all key mappings, generally ones specific to a plugin are in the plug-config folder

-- <leader>s to save
vim.keymap.set("n", "<leader>s", ":update<CR>") -- leader s to save

-- Always use g mode which moves through wrapped lines as if they were actual lines
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")

-- Undo these breakpoints when in insert mode
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "(", "(<c-g>u")

-- Make file executable
vim.keymap.set("n", "<leader>x", ":!chmod +x %<CR>")

-- Replace current word
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Only window
vim.keymap.set("n", "mo", ":wincmd o<CR>")

-- Quit with q: instead of bringing up cmd mode
-- vim.keymap.set("n", "q:", ":q<CR>")

vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>")

-- Select all with cmd-a
vim.keymap.set("n", "<D-a>", "ggVG")
vim.keymap.set("i", "<D-a>", "<Esc>ggVG")
vim.keymap.set("v", "<D-a>", "<Esc>ggVG")

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

-- Function to yank Python module path
_G.yank_module_path = function()
    local relative_path = vim.fn.expand("%:~:.") -- Get the relative path of the current file
    local module_path = relative_path:gsub("/", "."):gsub("%.py$", "") -- Replace / with . and remove .py extension
    
    -- Remove first directory if it's duplicated (e.g., sandbox/sandbox -> sandbox)
    local first_dir = module_path:match("^([^%.]+)%.")
    if first_dir and module_path:match("^" .. first_dir .. "%." .. first_dir .. "%.") then
        module_path = module_path:gsub("^" .. first_dir .. "%.", "")
    end
    
    -- Add python -m prefix
    local full_command = "python -m " .. module_path
    
    vim.api.nvim_call_function("setreg", { "+", full_command }) -- Set the clipboard register to the full command
    print("Module command yanked: " .. full_command) -- Notify the user
end

-- Map these yank functions to <leader>yr, <leader>yf, and <leader>ym
vim.keymap.set("n", "<leader>yr", ":lua _G.yank_relative_path()<CR>")
vim.keymap.set("n", "<leader>yf", ":lua _G.yank_full_path()<CR>")
vim.keymap.set("n", "<leader>ym", ":lua _G.yank_module_path()<CR>")

-- Open netrw file explorer with <leader>e
vim.keymap.set("n", "<leader>e", ":Ex<CR>")

-- Cmd+S to save (works in GUI Neovim)
vim.keymap.set({'n', 'i', 'v'}, '<D-s>', ':update<CR>')
-- Also map Ctrl+S for terminal compatibility
vim.keymap.set({'n', 'i', 'v'}, '<C-s>', ':update<CR>')

-- Window splits that focus the new window
vim.keymap.set("n", "<c-w>v", ":vsplit<CR>:wincmd l<CR>")
vim.keymap.set("n", "<c-w>s", ":split<CR>:wincmd j<CR>")

-- Window navigation with Ctrl+hjkl
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")

-- Toggle comments for Python (visual mode)
vim.keymap.set("v", "<D-/>", function()
    -- Get visual selection range
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    
    -- Check if all selected lines are commented
    local all_commented = true
    for line = start_line, end_line do
        local line_content = vim.fn.getline(line)
        if not line_content:match("^%s*#") then
            all_commented = false
            break
        end
    end
    
    -- Toggle comments
    for line = start_line, end_line do
        local line_content = vim.fn.getline(line)
        if all_commented then
            -- Remove comment
            local uncommented = line_content:gsub("^(%s*)#%s?", "%1")
            vim.fn.setline(line, uncommented)
        else
            -- Add comment
            local indent = line_content:match("^(%s*)")
            local rest = line_content:sub(#indent + 1)
            if rest ~= "" then
                vim.fn.setline(line, indent .. "# " .. rest)
            end
        end
    end
    
    -- Exit visual mode
    vim.cmd("normal! gv")
end)


local isLinux = (os.execute("uname -s | grep -q Linux") == 0)


-- Make <CR> accept selected completion item or insert new line
vim.keymap.set('i', '<CR>', function()
    if vim.fn.pumvisible() == 1 then
        -- If item is selected, accept it. Otherwise close menu and insert newline
        local item_selected = vim.fn.complete_info()['selected'] ~= -1
        return item_selected and '<C-y>' or '<C-e><CR>'
    else
        return '<CR>'
    end
end, { expr = true, desc = 'Accept completion or newline' })


-- Add scrolling keybindings for floating windows
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local win = vim.api.nvim_get_current_win()
        local config = vim.api.nvim_win_get_config(win)
        if config.relative ~= "" then  -- It's a floating window
            vim.keymap.set("n", "<C-n>", "<C-e>", { buffer = true, desc = "Scroll down" })
            vim.keymap.set("n", "<C-p>", "<C-y>", { buffer = true, desc = "Scroll up" })
            vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, desc = "Close window" })
            vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = true, desc = "Close window" })
        end
    end,
})

-- Require a file if on a Linux machine
if isLinux then 
    vim.api.nvim_command([[

    autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | execute 'OSCYankRegister +' | endif
    ]])
     vim.api.nvim_command([[
    autocmd TextYankPost * if v:event.operator is 'x' && v:event.regname is '+' | execute 'OSCYankRegister +' | endif
    ]])

    vim.api.nvim_command([[
    function! YankFullPathToOsc()
    let @+ = expand('%:p')
    OSCYankRegister +
    endfunction

    function! YankRelativePathToOsc()
    let @+ = expand('%:.')
    OSCYankRegister +
    endfunction
    ]])

    vim.api.nvim_set_keymap('n', '<leader>yr' , ':call YankRelativePathToOsc()<CR>', {noremap=true, silent=true })
    vim.api.nvim_set_keymap('n', '<leader>yf' , ':call YankFullPathToOsc()<CR>', {noremap=true, silent=true })
end

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
