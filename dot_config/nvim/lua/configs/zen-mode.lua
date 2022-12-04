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
