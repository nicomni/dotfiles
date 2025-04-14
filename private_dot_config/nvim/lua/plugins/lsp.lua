---@module "lazy"
---@type LazyPluginSpec[]
return {
	{
		"nvim-treesitter/playground",
	},
	{
		"nvim-lspconfig",
		opts = {
			--disable inlay-hints
			inlay_hints = { enabled = false },
		},
	},
}
