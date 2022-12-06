local ls = require("luasnip")

ls.config.setup({
	-- Keep the last snippet around.
	-- Useful for jumping back into the snippet.
	history = true,

	-- Dynamic snippet support
	updateevents = "TextChanged,TextChangedI",

	-- Autosnippets
	enable_autosnippets = true,
})

-- Use Ctrl-k to expand or jump forward in snippet
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

-- Use Ctrl-j to move to previous item within the snippets.
vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

-- Use Ctrl-l to select within a list of options
vim.keymap.set("i", "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

-- Shortcut to source luasnip file again
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")
