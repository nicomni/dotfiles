-- vim: fdm=marker foldenable

-- Bootstrap packer.nvim if not installed.
-- Thanks to packer.nvim author wbthomason.
-- Ref: https://github.com/wbthomason/packer.nvim#bootstrapping
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	local has_packer = pcall(require, "packer")
	if not has_packer then
		print("Installing packer")
		fn.system("git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path)
		vim.cmd("packadd packer.nvim")
		print("Finished installing packer.nvim")
		return true
	end
	return false
end

local needs_sync = ensure_packer()

local packages = {
	["packer"] = { "wbthomason/packer.nvim" },
	--{{{ File explorer
	["nvim-tree"] = {
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
	},
	--}}}

	--{{{ Focus mode
	["zen-mode"] = { "folke/zen-mode.nvim" },
	["twilight"] = { "folke/twilight.nvim" },
	--}}}

	--{{{ Diagnostics
	["trouble"] = {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	},
	--}}}

	--{{{ Mappings
	["Comment"] = { "numToStr/Comment.nvim" }, -- Comments
	["vim-unimpaired"] = { "tpope/vim-unimpaired" }, -- Brackets
	["vim-surround"] = { "tpope/vim-surround" }, -- Surrounds
	--}}}

	--{{{ Telescope
	["telescope"] = {
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = "nvim-lua/plenary.nvim",
	},
	["telescope-fzf-native"] = {
		"nvim-telescope/telescope-fzf-native.nvim",
		run = [[cmake -S. -Bbuild
    -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake 
    --install build --prefix build]],
	},
	--}}}

	--{{{ UI
	["nvim-web-devicons"] = { "kyazdani42/nvim-web-devicons" },
	["lualine"] = { "nvim-lualine/lualine.nvim" },
	["tabline"] = { "kdheepak/tabline.nvim" },
	--}}}

	--{{{ Language service
	["nvim-lspconfig"] = { "neovim/nvim-lspconfig" },
	["nvim-cmp"] = { "hrsh7th/nvim-cmp" }, -- completion
	["cmp-nvim-lsp"] = { -- LSP source for nvim-cmp
		"hrsh7th/cmp-nvim-lsp",
		opt = false,
	}, -- LSP source for nvim-cmp
	["SimpylFold"] = { "tmhedberg/SimpylFold" },
	["jsonc"] = { "neoclide/jsonc.vim" },
	["vim-pandoc"] = {
		"vim-pandoc/vim-pandoc",
		opt = true,
	},
	["vim-pandoc-syntax"] = {
		"vim-pandoc/vim-pandoc-syntax",
		opt = true,
	},
	["LuaSnip"] = { -- Snippets engine
		"L3MON4D3/LuaSnip",
		opt = false,
	},
	["cmp_luasnip"] = { -- Snippets source for nvim-cmp
		"saadparwaiz1/cmp_luasnip",
		opt = false,
	},
	["lspkind-nvim"] = {
		"onsails/lspkind-nvim",
		opt = false,
	},
	["tabular"] = {
		"godlygeek/tabular",
		opt = true,
	},
	["null-ls"] = {
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		opt = false,
	},
	["vimtex"] = {
		"lervag/vimtex",
		opt = true,
	},
	--}}}

	--{{{ Treesitter
	["nvim-treesitter"] = {
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	},
	--}}}

	--{{{ Other stuff
	["vim-tmux"] = {
		"tmux-plugins/vim-tmux",
		opt = true,
	},
	["vim-tmux-navigator"] = { "christoomey/vim-tmux-navigator" },
	["vim-fugitive"] = {
		"tpope/vim-fugitive",
		opt = true,
	},
	--}}}
}

local packer = require("packer")
packer.init()
packer.reset()

for _, package_spec in pairs(packages) do
	packer.use(package_spec)
end

if needs_sync then
	packer.sync()
end

return packer

-- return require("packer").startup(function()
-- 	use("wbthomason/packer.nvim") -- Let packer manage itself
-- 	-- Automatically set up your configuration after cloning packer.nvim
-- 	-- This must be at the end after all plugins
-- 	if needs_sync then
-- 		require("packer").sync()
-- 	end
-- end)
