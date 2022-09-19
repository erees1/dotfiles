-- Key Mappings
-- Note this is not all key mappings, generally ones specific to a plugin are in the plug-config folder
local r = { noremap = true, silent = true }

-- <leader>s to save
remap("n", "<leader>s", ":update<CR>", r) -- leader s to save

-- Always use g mode which moves through wrapped lines as if they were actual lines
remap("n", "j", "gj", { noremap = false, silent = true })
remap("n", "k", "gk", { noremap = false, silent = true })

-- Shift + HL to move to start and end of visual line
remap("n", "H", "g^", r)
remap("n", "L", "g$", r)
remap("v", "H", "g^", r)
remap("v", "L", "g$", r)

-- Shift + JK to move to top and bottom of the screen
remap("n", "J", "L", r)
remap("n", "K", "H", r)
remap("v", "J", "L", r)
remap("v", "K", "H", r)

-- Copy paste from system buffers to make copy paste behaviour more sane
remap("v", "y", '"+y', r)
remap("n", "y", '"+y', r)
remap("n", "Y", '"+y$', r)
remap("v", "x", '"+x', r)
remap("n", "x", '"+x', r)
remap("v", "p", '"+p', r)
remap("n", "p", '"+p', r)
remap("v", "d", '"+d', r)
remap("n", "d", '"+d', r)

-- Quick fix navigation
remap("n", "<M-n>", ":cn<CR>", r)
remap("n", "<M-p>", ":cp<CR>", r)

-- <leader><space> to clear highlighing after search
remap("n", "<Leader><space>", ":noh<CR>", r)

-- I always seem to delete stuff at the bottom of the file with d k so remove
remap("n", "dk", "<Nop>", r)

-- Keep it centered
remap("n", "n", "nzzzv", r)

-- Undo these breakpoints when in insert mode
remap("i", ",", ",<c-g>u", r)
remap("i", ".", ".<c-g>u", r)
remap("i", "(", "(<c-g>u", r)

-- Add new line without entering insert mode
remap("n", "<leader>o", ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', r)

-- Only window and reset bufferline to 0 offset
remap("n", "mo", "", { callback = function() 
    vim.cmd(':wincmd o')
    require("funcs").reset_bufferline()
end, r[0], r[1] })

-- Quit with q: instead of bringing up cmd mode
remap("n", "q:", ":q<CR>", r)

-- Start/end of line with ctrl-b ctrl-e in insert mode
remap("i", "<c-b>", "<c-o>^", r)
remap("i", "<c-e>", "<c-o>$", r)
-- remap("n", "<c-a>", "<Nop>", r)  -- ctrl a is tmux leader
remap("n", "<c-q>", "<c-a>", r)  -- ctrl q to increment

