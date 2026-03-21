local M = {}
local c = require("base46.colors")

local palette = {
  black = "#05080d",
  white = "#d0d8e8",
  gray = "#556070",
  pink = "#cc0066",
  cyan = "#00cccc",
  green = "#00cc33",
  purple = "#9900cc",
  orange = "#cc6e00",
  blue = "#0066cc",
  yellow = "#cccc00",
}

M.base_30 = {
  white = palette.white,
  black = palette.black,
  darker_black = c.change_hex_lightness(palette.black, -6),
  black2 = c.change_hex_lightness(palette.black, 4),
  one_bg = c.change_hex_lightness(palette.black, 8),
  one_bg2 = c.change_hex_lightness(palette.black, 12),
  one_bg3 = c.change_hex_lightness(palette.black, 16),
  grey = palette.gray,
  grey_fg = c.change_hex_lightness(palette.gray, 8),
  grey_fg2 = c.change_hex_lightness(palette.gray, 16),
  light_grey = c.change_hex_lightness(palette.gray, 24),
  red = palette.pink,
  baby_pink = c.mix(palette.pink, palette.white, 18),
  pink = palette.pink,
  line = c.change_hex_lightness(palette.black, 12),
  green = palette.green,
  vibrant_green = c.change_hex_lightness(palette.green, 8),
  nord_blue = palette.cyan,
  blue = palette.blue,
  yellow = palette.yellow,
  sun = c.change_hex_lightness(palette.orange, 6),
  purple = palette.purple,
  dark_purple = c.change_hex_lightness(palette.purple, -10),
  teal = palette.cyan,
  orange = palette.orange,
  cyan = palette.cyan,
  statusline_bg = c.change_hex_lightness(palette.black, 5),
  lightbg = c.change_hex_lightness(palette.black, 7),
  pmenu_bg = palette.purple,
  folder_bg = palette.blue,
}

M.base_16 = {
  base00 = M.base_30.black,
  base01 = M.base_30.black2,
  base02 = M.base_30.one_bg,
  base03 = M.base_30.one_bg2,
  base04 = M.base_30.one_bg3,
  base05 = M.base_30.white,
  base06 = c.change_hex_lightness(palette.white, 4),
  base07 = c.change_hex_lightness(palette.white, 8),
  base08 = palette.pink,
  base09 = palette.orange,
  base0A = palette.yellow,
  base0B = palette.green,
  base0C = palette.cyan,
  base0D = palette.blue,
  base0E = palette.purple,
  base0F = c.mix(palette.pink, palette.purple, 45),
}

M.type = "dark"

M = require("base46").override_theme(M, "cyberpunk-night")

return M
