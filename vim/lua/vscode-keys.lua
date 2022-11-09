-- Better Navigation
nnoremap("<C-j>", "<cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>")
nnoremap("<C-k>", "<cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>")
nnoremap("<C-h>", "<cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>")
nnoremap("<C-l>", "<cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>")
nnoremap("<C-w>_", "<cmd><C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>")
-- nnoremap("<c-d>", "30jzz")
-- nnoremap("<c-u>", "30kzz")
-- nnoremap("j", "jzz")
-- nnoremap("k", "kzz")

nnoremap("gr", "<cmd>call VSCodeNotify('editor.action.goToReferences')<CR>")
nnoremap("<leader>e", "<cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>")
nnoremap("<leader>t", "<cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>")
nnoremap("<leader>s", "<cmd>call VSCodeNotify('workbench.action.files.save')<CR>")
nnoremap("<leader>q", "<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>")
nnoremap("<leader>f", "<cmd>call VSCodeNotify('editor.action.formatDocument')<CR>")
nnoremap("<leader>yr", "<cmd>call VSCodeNotify('copyRelativeFilePath')<CR>:echo 'YANKED RELATIVE FILE PATH'<CR>")
nnoremap("<leader>yf", "<cmd>call VSCodeNotify('copyFilePath')<CR>:echo 'YANKED FILE PATH'<CR>")
nnoremap("<leader>rn", "<cmd>call VSCodeNotify('editor.action.rename')<CR>")
vnoremap("<leader>rn", "<cmd>call VSCodeNotify('editor.action.rename')<CR>")

-- Git navigation
nnoremap("<leader>hn", "<cmd>call VSCodeNotify('workbench.action.editor.nextChange')<CR>")
nnoremap("<leader>hp", "<cmd>call VSCodeNotify('git.timeline.openDiff')<CR>")

-- line indendation
nnoremap("<S-,>", "<cmd>call VSCodeNotify('editor.action.outdentLines')<CR>")
nnoremap("<S-.>", "<cmd>call VSCodeNotify('editor.action.indentLines')<CR>")
vnoremap("<S-,>", "<cmd>call VSCodeNotify('editor.action.outdentLines')<CR>")
vnoremap("<S-.>", "<cmd>call VSCodeNotify('editor.action.indentLines')<CR>")

-- Move through wrapped lines
-- remap(
-- 	"n",
-- 	"gk",
-- 	"<cmd> call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>",
-- 	r
-- )
-- remap(
-- 	"n",
-- 	"gj",
-- 	"<cmd> call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>",
-- 	r
-- )
