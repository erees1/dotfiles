
lua << EOF
print('running onedarker.vim')
package.loaded['onedarker'] = nil
package.loaded['onedark'] = nil

require("onedarker")
EOF
