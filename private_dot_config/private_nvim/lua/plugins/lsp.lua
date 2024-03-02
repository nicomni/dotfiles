local nls = require("null-ls")
return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      server_opts_overrides = {
        advanced = {
          indentationMode = {
            go = false,
          },
        },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = {
      sources = {},
    },
  },
}
