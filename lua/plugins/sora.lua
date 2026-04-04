return {
  {
    "Aejkatappaja/sora",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      italic_comments = true,
      on_colors = function(colors)
        -- colors.bg = "#000000"
      end,
      on_highlights = function(hl, colors)
        -- hl.Normal = { fg = colors.fg, bg = "#000000" }
      end,
    },
    config = function(_, opts)
      require("sora").setup(opts)
    end,
  },
}
