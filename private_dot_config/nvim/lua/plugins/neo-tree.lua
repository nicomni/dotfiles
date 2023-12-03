return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      default_component_configs = {
        icon = {
          folder_empty = "󰜌",
          folder_empty_open = "󰜌",
        },
        symbols = {
          renamed = "󰁕",
          unstaged = "󰄱",
        },
      },
      source_selector = {
        tab_levels = {
          filesystem = " 󰉓 Files ",
          buffers = " 󰈙 Buffers ",
          git_status = " 󰊢 Git ",
          diagnostics = " 󰒡 Diagnostics ",
        },
      },
    },
  },
}
