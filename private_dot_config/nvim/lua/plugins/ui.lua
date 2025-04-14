local keys = {
  ["zen-mode"] = {
    {
      "<leader>uz",
      function()
        require("zen-mode").toggle()
      end,
      desc = "Toggle Focus (Zen) mode",
    },
  },
}
--- @type LazyPluginSpec[]
local ui = {
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        window = {
          width = 130,
        },
        options = {
          number = false,
          relativenumber = false,
          cursorline = false,
          list = false,
        },
        plugins = {
          options = {
            enabled = true,
            relativenumber = false,
            number = false,
          },
          kitty = {
            enabled = true,
            font = "+10",
          },
          twilight = { enabled = false },
        },
      })
    end,
    keys = keys["zen-mode"],
  },
  { "folke/twilight.nvim" },
}

return ui
