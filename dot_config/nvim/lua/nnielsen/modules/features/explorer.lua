local explorer = {}

explorer.packages = {
	["nvim-tree.lua"] = {
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
	},
}

explorer.configs = {
	["nvim-tree.lua"] = function()
		require("nvim-tree").setup({
			view = {
				width = 50,
			},
			actions = {
				change_dir = {
					global = true,
				},
			},
		})
	end,
}

return explorer
