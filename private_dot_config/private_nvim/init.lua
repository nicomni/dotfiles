-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Add filetype mappings:
vim.filetype.add({
	extension = {
		geojson = "json",
	},
})
