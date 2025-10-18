---@module "snacks"
---@module "lazy.types"
---@type LazyPluginSpec[]
return {
  {
    "lewis6991/gitsigns.nvim",
    version = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          always_show_by_pattern = {
            "**/epic-react/v2/**/playground",
          },
        },
      },
    },
    dependencies = {
      "s1n7ax/nvim-window-picker",
      name = "window-picker",
    },
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      ---@type snacks.picker.Config
      picker = {
        layout = {
          cycle = true,
          preset = function()
            return vim.o.columns >= 160 and "default" or "vertical"
          end,
        },
      },
    },
  },
  {
    "nvim-mini/mini.align",
    version = "*",
    config = true,
  },
}
