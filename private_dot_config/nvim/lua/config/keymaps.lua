-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps hereby

local wk = require("which-key")
local Editor = require("magganielsen.editor")

local map = vim.keymap.set

map("i", "jk", "<ESC>", { silent = true, desc = "End insert mode" })
map("n", "<leader>ub", Editor.toggle_background, { silent = true, desc = "Toggle dark/light mode" })
map("n", "<leader>T", Editor.open_terminal, { silent = true, desc = "Open terminal" })
