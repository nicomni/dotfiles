---@type Module
local testing = {}

testing.packages = {
	--[[ ["vim-test"] = {
		"vim-test/vim-test",
		requires = "tpope/vim-dispatch",
	}, ]]
	["neotest"] = {
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
		},
	},
}

testing.configs = {
	["neotest"] = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python"),
			},
		})
	end,
}

return testing
