return {
	-- snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function(_, opts)
			local ls = require("luasnip")
			local loader_vscode = require("luasnip.loaders.from_vscode")
			ls.config.setup(opts)

			ls.filetype_extend("zsh", { "shelldoc" })
			ls.filetype_extend("sh", { "shelldoc" })

			loader_vscode.lazy_load()
		end,
	},
}
