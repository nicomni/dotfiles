local keys = {
  ["nvim-dap"] = {
    {
      "<leader>dc",
      function() require("dap").continue() end,
      desc =
      "Continue"
    },
    {
      "<leader>dso",
      function() require("dap").step_over() end,
      desc =
      "Step over"
    },
    {
      "<leader>dsi",
      function() require("dap").step_into() end,
      desc =
      "Step into"
    },
    {
      "<leader>dsu",
      function() require("dap").step_out() end,
      desc =
      "Step out"
    },
    {
      "<leader>db",
      function() require("dap").toggle_breakpoint() end,
      desc =
      "Toggle breakpoint"
    },
    {
      "<leader>dC",
      function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
      desc =
      "Conditional breakpoint"
    },
    {
      "<leader>dr",
      function() require("dap").repl.open() end,
      desc =
      "Open REPL"
    },
    {
      "<leader>dl",
      function() require("dap").run_last() end,
      desc =
      "Run last"
    },
    { "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "Hover" }
  },
  ["dapui"] = {
    { "<leader>dd", function() require("dapui").toggle() end, desc = "Toggle DapUI" }
  }
}
---@type LazyPlugin[]
local debugging = {
  {
    "mfussenegger/nvim-dap",
    keys = keys["nvim-dap"]
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    config = function()
      require("mason-nvim-dap").setup({
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      })
    end,
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim"
    }
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap"
    },
    main = "dapui",
    config = true,
    keys = keys["dapui"]
  }
}
return debugging
