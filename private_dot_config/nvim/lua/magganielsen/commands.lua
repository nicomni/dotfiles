vim.api.nvim_create_user_command("LuaSnipEdit", function()
  require("luasnip.loaders").edit_snippet_files()
end, { desc = "Edit snippets" })
