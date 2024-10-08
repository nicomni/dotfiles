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
    "L3MON4D3/LuaSnip",
    opts = {
      load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft({
        typescriptreact = { "typescript" },
      }),
    },
  },
}
