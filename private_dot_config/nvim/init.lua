-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local has_ls = pcall(require, "luasnip")
if has_ls then
	-- load my snippets
	local lua_loader = require("luasnip.loaders.from_lua")
	lua_loader.lazy_load({ paths = vim.list_extend({ "~/repos/snippetfiles/" }, vim.opt.rtp) })

	-- add shelldoc snippets to shell files
	local ls = require("luasnip")
	ls.filetype_extend("zsh", { "shelldoc" })
	ls.filetype_extend("sh", { "shelldoc" })
end

-- Add filetype mappings:
vim.filetype.add({
	extension = {
		geojson = "json",
	},
})
