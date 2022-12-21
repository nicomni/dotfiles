---@type Module
local tmux = {}

tmux.packages = {
	--{{{ Other stuff
	["vim-tmux"] = {
		"tmux-plugins/vim-tmux",
	},
	["vim-tmux-navigator"] = { "christoomey/vim-tmux-navigator" },
	["vim-fugitive"] = {
		"tpope/vim-fugitive",
	},
}

return tmux
