---@type Module
local ui = {}

ui.packages = {

	["tokyonight"] = { "folke/tokyonight.nvim" },
	["nvim-web-devicons"] = { "kyazdani42/nvim-web-devicons" },
	-- FIXME: Lualine causes intro screen to be disabled
	["lualine.nvim"] = { "nvim-lualine/lualine.nvim" },
	["tabline.nvim"] = { "kdheepak/tabline.nvim" },
}

ui.configs = {
	["lualine.nvim"] = function()
		--TODO
		require("lualine").setup({
			options = {
				theme = "tokyonight",
			},
			tabline = {},
		})
	end,
	["tabline.nvim"] = function()
		require("tabline").setup({})
	end,
}

return ui
