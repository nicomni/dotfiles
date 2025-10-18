---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "nvim-lspconfig",
    opts = {
      --disable inlay-hints
      inlay_hints = { enabled = false },
    },
  },
}
