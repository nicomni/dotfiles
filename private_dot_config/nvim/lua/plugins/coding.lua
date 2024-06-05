return {
	-- snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function(_, opts)
			local ls = require("luasnip")
			ls.config.setup(opts)
			local loader_vscode = require("luasnip.loaders.from_vscode")
			local loader_lua = require("luasnip.loaders.from_lua")
			ls.filetype_extend("zsh", { "shelldoc" })
			ls.filetype_extend("sh", { "shelldoc" })

			loader_vscode.lazy_load()
			loader_lua.lazy_load({ paths = vim.list_extend({ "~/repos/snippetfiles/" }, vim.opt.runtimepath) })
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		enabled = false,
	},
}
