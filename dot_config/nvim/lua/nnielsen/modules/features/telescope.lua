---@type Module
local telescope = {}

telescope.packages = {

	["telescope"] = {
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = "nvim-lua/plenary.nvim",
	},
	["telescope-fzf-native"] = {
		"nvim-telescope/telescope-fzf-native.nvim",
		run = [[cmake -S. -Bbuild
    -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake 
    --install build --prefix build]],
	},
}

telescope.configs = {
	["telescope"] = function()
		require("telescope").setup({
			defaults = {
				prompt_prefix = "$ ",
			},
		})
	end,
}

return telescope
