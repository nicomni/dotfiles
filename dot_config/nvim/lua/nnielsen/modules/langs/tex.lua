local g = vim.g
---@type Module
local tex = {}

tex.packages = {
	["vimtex"] = {
		"lervag/vimtex",
		ft = { "tex" },
	},
}

tex.configs = {
	["vimtex"] = function()
		-- Use Skim as viewer application for vimtex
		g.vimtex_view_method = "skim"
		-- Disable custom warnings based on regexp
		g.vimtex_quickfix_ignore_filters = {
			"Font shape declaration has incorrect series value",
			"Overfull \\hbox",
			"Marginpar on page",
			"No \\printglossary",
			"You have requested document class",
			"The length marginparwidth is less than",
			"Draft mode on",
		}
		--let g:vimtex_subfile_start_local = 1
		--let g:vimtex_fold_enabled = 1
		g.vimtex_fold_enabled = 1
	end,
}

return tex
