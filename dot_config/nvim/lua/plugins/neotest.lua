local neotest_keys = {
  { "<leader>tn", function() require("neotest").run.run({ extra_args = { "-vv", "-s" } }) end,
                                                                                           desc = "Run the nearest test" },
  { "<leader>ts", function() require("neotest").summary.toggle() end,                    desc = "Toggle summary window" },
  { "<leader>to", function() require("neotest").output.open({ enter = true }) end,       desc = "View output" },
  { "<leader>tf", function() require("neotest").run.run(vim.fn.expand('%')) end,         desc = "Test current file" },
  { "<leader>tl", function() require("neotest").run.run_last() end,                      desc = "Run last test" },
  { "<leader>tm", function() require("neotest").summary.run_marked() end,                desc =
  "Run marked tests (summary)" },
}

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python"
    },
    lazy = true,
    opts = function(_, _)
      local adapter_py = require("neotest-python")
      local opts = {
        adapters = {
          adapter_py
        },
        quickfix = {
          open = false
        }
      }
      return opts
    end,
    ft = "python",
    keys = neotest_keys
  },
}
