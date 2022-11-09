-- Key Mappings
-- Note this is not all key mappings, generally ones specific to a plugin are in the plug-config folder

-- <leader>s to save
nnoremap("<leader>s", ":update<CR>") -- leader s to save

-- Always use g mode which moves through wrapped lines as if they were actual lines
nmap("j", "gj")
nmap("k", "gk")

-- Shift + HL to move to start and end of visual line
nnoremap("H", "g^")
nnoremap("L", "g$")
vnoremap("H", "g^")
vnoremap("L", "g$")

-- Shift + JK to move to top and bottom of the screen
nnoremap("J", "L")
nnoremap("K", "H")
vnoremap("J", "L")
vnoremap("K", "H")

-- Copy paste from system buffers to make copy paste behaviour more sane
vnoremap("y", '"+y')
nnoremap("y", '"+y')
nnoremap("Y", '"+y$')
vnoremap("x", '"+x')
nnoremap("x", '"+x')
vnoremap("p", '"+p')
nnoremap("p", '"+p')
vnoremap("d", '"+d')
nnoremap("d", '"+d')

-- Quick fix navigation
nnoremap("<M-n>", ":cn<CR>")
nnoremap("<M-p>", ":cp<CR>")

-- <leader><space> to clear highlighing after search
nnoremap("<Leader><space>", ":noh<CR>")

-- I always seem to delete stuff at the bottom of the file with d k so remove
nnoremap("dk", "<Nop>")

-- Keep it centered
nnoremap("n", "nzzzv")

-- Undo these breakpoints when in insert mode
inoremap(",", ",<c-g>u")
inoremap(".", ".<c-g>u")
inoremap("(", "(<c-g>u")

-- Add new line without entering insert mode
nnoremap("<leader>o", ':<C-u>call append(line("."), repeat([""], v:count1))<CR>')

-- Only window and reset bufferline to 0 offset
vim.api.nvim_set_keymap("n", "mo", "", {
    callback = function()
        vim.cmd(":wincmd o")
        require("funcs").reset_bufferline()
    end,
    noremap = true,
    silent = true,
})

-- Quit with q: instead of bringing up cmd mode
nnoremap("q:", ":q<CR>")

-- Start/end of line with ctrl-b ctrl-e in insert mode
inoremap("<c-b>", "<c-o>^")
inoremap("<c-e>", "<c-o>$")
-- nnoremap("<c-a>", "<Nop>")  -- ctrl a is tmux leader
nnoremap("<c-q>", "<c-a>") -- ctrl q to increment
