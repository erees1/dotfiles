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
vim.keymap.set("n", "q:", ":q<CR>")

vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>")

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

-- Map these yank functions to <leader>yr and <leader>yf
vim.keymap.set("n", "<leader>yr", ":lua _G.yank_relative_path()<CR>")
vim.keymap.set("n", "<leader>yf", ":lua _G.yank_full_path()<CR>")
