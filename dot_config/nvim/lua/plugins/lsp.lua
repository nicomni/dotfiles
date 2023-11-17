local nls = require("null-ls")
return {
  {
    "neovim/nvim-lspconfig",
    version = false,
    ---@class PluginLspOpts
    opts = {
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
        texlab = {},
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = {
      sources = {
        nls.builtins.formatting.isort,
        nls.builtins.formatting.black,
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      server_opts_overrides = {
        advanced = {
          indentationMode = {
            go = false
          }
        }
      }
    },
  }
}
