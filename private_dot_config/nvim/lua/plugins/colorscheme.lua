return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
      ---@param colors ColorScheme
      on_colors = function(colors)
        colors.border = colors.orange
      end,
    },
  },
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
