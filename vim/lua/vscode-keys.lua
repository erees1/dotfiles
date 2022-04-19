-- -- VSCode
local r = {noremap=true, silent=false}

 -- Better Navigation 
remap('n', '<C-j>', "<cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>", r)
remap('n', '<C-k>', "<cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>", r)
remap('n', '<C-h>', "<cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>", r)
remap('n', '<C-l>', "<cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>", r)
remap('n', '<C-w>_',  "<cmd><C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>", r)

remap('n', 'gr', "call VSCodeNotify('editor.action.goToReferences')<CR>", r)
remap('n', '<leader>e', "<cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>", r)
remap('n', '<leader>tf', "<cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>", r)
remap('n', '<leader>s', "<cmd>call VSCodeNotify('workbench.action.files.save')<CR>", r)
remap('n', '<leader>q', "<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>", r)
remap('n', '<leader>f', "<cmd>call VSCodeNotify('editor.action.formatDocument')<CR>", r)
remap('n', '<leader>yr', "<cmd>call VSCodeNotify('copyRelativeFilePath')<CR>:echo 'YANKED RELATIVE FILE PATH'<CR>", r)
remap('n', '<leader>yf', "<cmd>call VSCodeNotify('copyFilePath')<CR>:echo 'YANKED FILE PATH'<CR>", r)
remap('n', '<leader>rn', "<cmd>call VSCodeNotify('editor.action.rename')<CR>", r)
remap('v', '<leader>rn', "<cmd>call VSCodeNotify('editor.action.rename')<CR>", r)

-- Git navigation
remap('n', '<leader>hn',  "<cmd>call VSCodeNotify('workbench.action.editor.nextChange')<CR>", r)
remap('n', '<leader>hp',  "<cmd>call VSCodeNotify('git.timeline.openDiff')<CR>", r)

-- line indendation
remap('n', '<S-,>',  "<cmd>call VSCodeNotify('editor.action.outdentLines')<CR>", r)
remap('n', '<S-.>',  "<cmd>call VSCodeNotify('editor.action.indentLines')<CR>", r)
remap('v', '<S-,>',  "<cmd>call VSCodeNotify('editor.action.outdentLines')<CR>", r)
remap('v', '<S-.>',  "<cmd>call VSCodeNotify('editor.action.indentLines')<CR>", r)

-- Move through wrapped lines
remap('n', 'gk',  "<cmd> call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>", r)
remap('n', 'gj',  "<cmd> call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>", r)
