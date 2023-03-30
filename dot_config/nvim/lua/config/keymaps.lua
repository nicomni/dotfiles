-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps hereby

local wk = require("which-key")

local Util = require("lazyvim.util")

-- Default opts by which-key:
-- {
--   mode = "n", -- normal mode
--   -- prefix: use "<leader>f" for example for mapping everything related to finding files
--   -- the prefix is prepended to every mapping part of `mappings`
--   prefix = "",
--   buffer = nil, -- global mappings. specify a buffer number for buffer local mappings
--   silent = true, -- use `silent` when creating keymaps
--   noremap = true, -- use `noremap` when creating keymaps
--   nowait = false, -- use `nowait` when creating keymaps
-- }

local keymaps = {
  {
    mode = "i",
    ["jk"] = { "<ESC>", "End insert mode" }
  }
}

if Util.has("neotest") then
  keymaps["<leader>t"] = { name = "+neotest", mode = { "n", "v" } }
end

wk.register(keymaps)
