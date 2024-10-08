-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps hereby

local wk = require("which-key")


local keymaps = {
	{
		mode = "i",
		["jk"] = { "<ESC>", "End insert mode" },
	},
	{
		["<leader>ub"] = {
			function()
				if vim.o.background == "light" then
					vim.o.background = "dark"
				elseif vim.o.background == "dark" then
					vim.o.background = "light"
				end
			end,
			"Toggle dark/light mode",
		},
	},
}

wk.register(keymaps)
