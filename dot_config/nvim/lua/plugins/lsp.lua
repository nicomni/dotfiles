local nls = require("null-ls")
return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = {
      sources = {
        nls.builtins.formatting.isort,
        nls.builtins.formatting.black,
      },
    },
  },
}
