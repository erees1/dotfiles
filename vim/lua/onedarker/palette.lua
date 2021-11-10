--Import colors from onedark and override
package.loaded["onedark.palette"] = nil
local colors = require "onedark.palette"
colors["bg"] = "#1f2227"
colors["alt_bg"] = "#282c34"
colors["dark"] = "#282c34"

return colors
