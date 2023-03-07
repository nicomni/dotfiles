---@type Module
local treesitter = {}

treesitter.packages = {
	["nvim-treesitter"] = {
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	},
}

treesitter.configs = {
	["nvim-treesitter"] = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"typescript",
				"tsx",
			},

			-- Ignore latex. See :h vimtex-faq-treesitter
			ignore_install = { "latex" },

			sync_install = false,

			auto_install = true,

			highlight = { enable = true, additional_vim_regex_highlighting = false },
		})
	end,
}

return treesitter
