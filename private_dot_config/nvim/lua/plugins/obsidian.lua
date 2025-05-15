local obsidianpath = vim.env["OBSIDIANPATH"]
obsidianpath =
  vim.fs.normalize(obsidianpath ~= nil and obsidianpath or vim.fs.joinpath(vim.fn.stdpath("data"), "obsidian/"))
---@type LazyPluginSpec[]
return {
  { -- not managed by LazyVim
    -- see: https://github.com/obsidian-nvim/obsidian.nvim
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    event = "BufEnter " .. obsidianpath .. "/**/*",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personlig",
          path = vim.fs.joinpath(obsidianpath, "/personlig"),
        },
      },
      ui = {
        enable = false,
      },
    },
  },

  ---@module "snacks"
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      image = {
        enabled = true,
        img_dirs = { "Ekstra/Vedlegg" },
      },
    },
  },
}
