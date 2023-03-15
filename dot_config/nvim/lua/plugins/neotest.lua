-- TODO: Register test commands with which-key
local neotest_keys = {
  { "<leader>tn", function() require("neotest").run.run() end,        desc = "Run the nearest test" },
  { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle summary window" }
}

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim"
    },
    lazy = true
  },
  {
    "nvim-neotest/neotest-python",
    dependencies = {
      "nvim-neotest/neotest",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")
        }
      })
    end,
    ft = "python",
    keys = neotest_keys
  }
}
