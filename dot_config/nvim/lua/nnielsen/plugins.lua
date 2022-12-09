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
	-- File explorer
	["nvim-tree"] = {
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
	},

	-- Focus mode
	["zen-mode"] = { "folke/zen-mode.nvim" },
	["twilight"] = { "folke/twilight.nvim" },

	-- Diagnostics
	["trouble"] = {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	},

	-- Mappings
	["Comment"] = { "numToStr/Comment.nvim" }, -- Comments
	["vim-unimpaired"] = { "tpope/vim-unimpaired" }, -- Brackets
	["vim-surround"] = { "tpope/vim-surround" }, -- Surrounds

	-- Telescope
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

	-- UI
	["nvim-web-devicons"] = { "kyazdani42/nvim-web-devicons" },
	["lualine"] = { "nvim-lualine/lualine.nvim" },
	["tabline"] = { "kdheepak/tabline.nvim" },

	-- Language service
	["nvim-lspconfig"] = { "neovim/nvim-lspconfig" },
	["nvim-cmp"] = { "hrsh7th/nvim-cmp" }, -- completion
	["cmp-nvim-lsp"] = { -- LSP source for nvim-cmp
		"hrsh7th/cmp-nvim-lsp",
		disable = true,
	}, -- LSP source for nvim-cmp

	["LuaSnip"] = { -- Snippets engine
		"L3MON4D3/LuaSnip",
		disable = true,
	},
	["cmp_luasnip"] = { -- Snippets source for nvim-cmp
    "saadparwaiz1/cmp_luasnip",
    disable = true
  },
  ["lspkind-nvim"] = {
    "onsails/lspkind-nvim",
    disable = true
  },
  ["null-ls"] = {
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
    disable = true
  },

	-- Other stuff
	["vim-tmux-navigator"] = { "christoomey/vim-tmux-navigator" },
}

return require("packer").startup(function()
	use("wbthomason/packer.nvim") -- Let packer manage itself
	use({
		"kyazdani42/nvim-tree.lua", -- File explorer
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		tag = "nightly",
	})
	use("folke/zen-mode.nvim") -- Zen Mode
	use("folke/twilight.nvim") -- Dim inactive portions of text
	use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })
	-- use("folke/lsp-colors.nvim") -- Adds LSP diagnostics hl groups if missing
	use("christoomey/vim-tmux-navigator") -- vim <--> tmux navigation
	use("numToStr/Comment.nvim") -- Mappings for comments
	use("tpope/vim-unimpaired") -- Bracket navigation
	use("tpope/vim-surround") -- All things surround
	--{{{ Telescope
	use({
		"nvim-telescope/telescope.nvim", -- The power of the moon
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = [[cmake -S. -Bbuild
    -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake 
    --install build --prefix build]],
	})
	--}}}
	--[[ use({
		"dracula/vim", -- a colorscheme
		as = "dracula",
	}) ]]
	use("kyazdani42/nvim-web-devicons") -- cool icons
	use("nvim-lualine/lualine.nvim") -- statusline
	use("kdheepak/tabline.nvim") -- tabline
	-- {{{ LSP stuff

	-- A collection of LSP configs. See :help lspconfig
	use("neovim/nvim-lspconfig")
	use("hrsh7th/nvim-cmp") -- Autocompletion plugin
	use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
	use("L3MON4D3/LuaSnip") -- Snippets plugin
	use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
	use("onsails/lspkind-nvim")
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	-- Improved folding for python
	use("tmhedberg/SimpylFold")

	-- Filetype plugin for jsonc
	use("neoclide/jsonc.vim") --

	-- (No longer using) Features for editing bash scripts.
	--use 'WolfgangMehner/bash-support'

	-- Community maintained snippets library
	-- use("honza/vim-snippets")

	-- Go language features
	--use { 'fatih/vim-go', run = ':GoUpdateBinaries' }

	-- Filetype plugin for .tmux.conf file
	use("tmux-plugins/vim-tmux")

	-- Tree-sitter convenient features
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})

	-- }}}
	--{{{ Disabled
	-- use("tpope/vim-fugitive") -- Git commands

	-- use 'lervag/vimtex'

	-- Automated bullet lists (including checkboxes)
	-- use("dkarter/bullets.vim")

	-- Text alignment.
	-- use("godlygeek/tabular")

	-- Syntax highlighting, matching rules and mappings for markdown.
	-- See: https://github.com/preservim/vim-markdown#vim-markdown
	--use 'preservim/vim-markdown'
	-- use("vim-pandoc/vim-pandoc")
	-- use("vim-pandoc/vim-pandoc-syntax")

	--}}}
	-- Automatically set up your configuration after cloning packer.nvim
	-- This must be at the end after all plugins
	if needs_sync then
		require("packer").sync()
	end
end)
