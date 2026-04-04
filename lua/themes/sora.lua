local M = {}
local c = require("base46.colors")

local palette = {
  black = "#0e1018",
  white = "#c8d0e0",
  cyan = "#80c8e0",
  purple = "#b0a0d8",
  green = "#90c8a0",
  orange = "#d0a888",
  yellow = "#d4b878",
  red = "#d0909c",
  teal = "#78b8b0",
  gray = "#8898b8",
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
  red = palette.red,
  baby_pink = c.mix(palette.red, palette.white, 30),
  pink = palette.red,
  line = c.change_hex_lightness(palette.black, 14),
  green = palette.green,
  vibrant_green = c.change_hex_lightness(palette.green, 8),
  nord_blue = palette.cyan,
  blue = palette.cyan,
  yellow = palette.yellow,
  sun = c.change_hex_lightness(palette.yellow, 6),
  purple = palette.purple,
  dark_purple = c.change_hex_lightness(palette.purple, -10),
  teal = palette.teal,
  orange = palette.orange,
  cyan = palette.cyan,
  statusline_bg = c.change_hex_lightness(palette.black, 6),
  lightbg = c.change_hex_lightness(palette.black, 8),
  pmenu_bg = palette.purple,
  folder_bg = palette.cyan,
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
  base08 = palette.red,
  base09 = palette.orange,
  base0A = palette.yellow,
  base0B = palette.green,
  base0C = palette.teal,
  base0D = palette.cyan,
  base0E = palette.purple,
  base0F = c.mix(palette.orange, palette.red, 50),
}

M.type = "dark"

M = require("base46").override_theme(M, "sora")

return M
