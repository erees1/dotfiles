local util = require("onedark.util")

local colors = {
  none = "NONE",
  fg = "#abb2bf",
  bg = "#282c34",
  alt_bg = "#1f2227",
  dark = "#1f2227",
  accent = "#BBBBBB",
  dark_gray = "#2a2f3e",
  fg_gutter = "#353d46",
  context = "#4b5263",
  popup_back = "#282c34",
  search_orange = "#613214",
  search_blue = "#5e81ac",
  gray = "#5c6370",
  light_gray = "#abb2bf",
  blue = "#61AFEF",
  dark_blue = "#223E55",
  green = "#98C379",
  cyan = "#56B6C2",
  red = "#e06c75",
  orange = "#D19A66",
  light_red = "#be5046",
  yellow = "#E5C07B",
  yellow_orange = "#D7BA7D",
  purple = "#C678DD",
  magenta = "#D16D9E",
  cursor_fg = "#515052",
  cursor_bg = "#AEAFAD",
  sign_add = "#587c0c",
  sign_change = "#0c7d9d",
  sign_delete = "#94151b",
  error_red = "#F44747",
  warning_orange = "#ff8800",
  info_yellow = "#FFCC66",
  hint_blue = "#4FC1FF",
  purple_test = "#ff007c",
  cyan_test = "#00dfff",
  ui_blue = "#264F78",
  --taken from tokyonight
  green2 = "#41a6b5",
  red1 = "#db4b4b",
  blue7 = "#394b70",
}

colors.diff_add = util.darken(colors.green, 0.15, colors.bg)
colors.diff_delete = util.darken(colors.red, 0.15, colors.bg)
colors.diff_change = util.darken(colors.blue, 0.15, colors.bg)
colors.diff_text = colors.blue7


return colors
