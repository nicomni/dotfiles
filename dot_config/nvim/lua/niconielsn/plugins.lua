return require("packer").startup(function()
	use("wbthomason/packer.nvim") -- Packer self manage
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
	use("tpope/vim-fugitive") -- Git commands
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
	use({
		"dracula/vim", -- a colorscheme
		as = "dracula",
	})
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
end)
-- vim: fdm=marker foldenable
