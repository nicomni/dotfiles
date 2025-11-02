-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
  group = vim.api.nvim_create_augroup("KittySetVarVimEnter", { clear = true }),
  callback = function()
    io.stdout:write("\x1b]1337;SetUserVar=in_editor=MQo\007")
  end,
})

vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
  group = vim.api.nvim_create_augroup("KittyUnsetVarVimLeave", { clear = true }),
  callback = function()
    io.stdout:write("\x1b]1337;SetUserVar=in_editor\007")
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyLoad",
  callback = function(ev)
    if ev.data ~= "LuaSnip" then
      return
    end
    local has_ls, ls_or_err = pcall(require, "luasnip")
    if has_ls then
      local ls = ls_or_err
      -- load my snippets
      local lua_loader = require("luasnip.loaders.from_lua")
      local snippets_path = vim.fn.expand("~/dev/repos/nicomni/snippetfiles/luasnippets")
      lua_loader.lazy_load({ paths = { snippets_path } })

      -- add shelldoc snippets to shell files
      ls.filetype_extend("zsh", { "shelldoc" })
      ls.filetype_extend("sh", { "shelldoc" })

      ls.filetype_extend("javascript", { "javascriptreact" })
      ls.filetype_extend("typescript", { "typescriptreact" })
      ls.filetype_extend("javascriptreact", { "javascript" })
      ls.filetype_extend("typescriptreact", { "typescript" })
    else
      vim.notify(string.format("LuaSnip was not found: %s", ls_or_err), vim.log.levels.ERROR)
    end
  end,
})

-- Add filetype mappings:
vim.filetype.add({
  extension = {
    geojson = "json",
  },
})

require("magganielsen.commands")
