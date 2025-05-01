-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps hereby

-- Wrapper function around vim.keymap.set with custom defaults
---@param mode string|string[] Mode "short-name" (see |nvim_set_keymap()|), or a list thereof.
---@param lhs string           Left-hand side |{lhs}| of the mapping.
---@param rhs string|function  Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param opts? vim.keymap.set.Opts
---
---@see vim.keymap.set
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false -- Default to true unless explicitly set to false
  vim.keymap.set(mode, lhs, rhs)
end

map("i", "jk", "<ESC>", { desc = "End insert mode" })

map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up one line" })
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down one line" })

map("n", "J", "mzJ`z:delmarks z<CR>", { desc = "Join lines. Keep cursor position" })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "nv", "v" }, "<leader>d", '"_d', { desc = "Delete from universe!" })
map("n", "Q", "<nop>") -- Just don't...
