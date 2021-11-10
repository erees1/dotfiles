
lua << EOF
print('running onedark.vim')
package.loaded['onedark'] = nil

require("onedark")
EOF
