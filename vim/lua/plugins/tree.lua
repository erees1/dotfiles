function _tree_toggle()
    if require'nvim-tree.view'.win_open() then
        require'bufferline.state'.set_offset(0)
    else
        require'bufferline.state'.set_offset(tree_width + 1, 'FileTree')
    end
    require'nvim-tree'.toggle()
end
