---@type Module
local focus = {}

focus.packages = {
	["zen-mode"] = { "folke/zen-mode.nvim" },
	["twilight"] = { "folke/twilight.nvim" },
}

focus.configs = {
	["twilight"] = function()
		require("twilight").setup()
	end,
	["zen-mode"] = function()
		require("zen-mode").setup({
			window = {
				options = {
					number = false,
					relativenumber = false,
				},
				width = 80,
			},
			plugins = {
				options = {
					enabled = true,
					ruler = false,
					showcmd = false,
				},
				tmux = { enabled = true },
			},
		})
	end,
}

return focus
