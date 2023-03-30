return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
      ---@param colors ColorScheme
      on_colors = function(colors)
        colors.border = colors.orange
      end,
    }
  }
}
