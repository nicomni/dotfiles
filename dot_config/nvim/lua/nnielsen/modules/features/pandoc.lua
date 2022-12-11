---@type Module
local pandoc = {}

pandoc.packages = {
	["vim-pandoc"] = {
		"vim-pandoc/vim-pandoc",
		opt = true,
	},
	["vim-pandoc-syntax"] = {
		"vim-pandoc/vim-pandoc-syntax",
		opt = true,
	},
}

return pandoc
