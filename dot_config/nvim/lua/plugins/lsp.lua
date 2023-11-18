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
}
