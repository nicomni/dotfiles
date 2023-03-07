local map = vim.keymap.set

local opts = { noremap = true, silent = true }

-- vim.g.mapleader = ' ' -- use space as <leader>

-- Open file explorer
map("n", "<leader>fe", ":NvimTreeToggle<CR>", opts)

-- Use 'jk' to quit insert mode
map("i", "jk", "<ESC>", opts)

--{{{ Telescope
local tsbuiltin = require("telescope.builtin")
local tsthemes = require("telescope.themes")

-- Fuzzy find files with Telescope
map({ "i", "n" }, "<leader>ff", function()
	tsbuiltin.find_files(tsthemes.get_ivy())
end, opts)

-- Fuzzy find current buffer with Telescope
map("n", "<C-/>", function()
	tsbuiltin.current_buffer_fuzzy_find(tsthemes.get_ivy())
end, opts)

--}}}

-- More convenient keys for window movement
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Edit init.lua
map("n", "<leader>ev", "<cmd>tabedit $MYVIMRC<CR>", opts)
-- Source init.lua
map("n", "<leader>sv", "<cmd>luafile $MYVIMRC<CR>", opts)

-- vim: fdm=marker foldenable
