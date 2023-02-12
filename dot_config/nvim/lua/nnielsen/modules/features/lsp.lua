---@type Module
local lsp = {}

lsp.packages = {
	["nvim-lspconfig"] = { "neovim/nvim-lspconfig" },
	["nvim-cmp"] = {
		"hrsh7th/nvim-cmp",
		after = { "LuaSnip", "lspkind-nvim" },
	}, -- completion
	["cmp-nvim-lsp"] = { -- LSP source for nvim-cmp
		"hrsh7th/cmp-nvim-lsp",
	}, -- LSP source for nvim-cmp
	["LuaSnip"] = { -- Snippets engine
		"L3MON4D3/LuaSnip",
	},
	["cmp_luasnip"] = { -- Snippets source for nvim-cmp
		"saadparwaiz1/cmp_luasnip",
		after = "LuaSnip",
	},
	["lspkind-nvim"] = {
		"onsails/lspkind-nvim",
	},
	["null-ls"] = {
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		opt = false,
	},
	["trouble.nvim"] = {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	},
}

lsp.configs = {
	["nvim-lspconfig"] = function()
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = false,
		})

		local signs = {
			Error = " ",
			Warn = " ",
			Hint = " ",
			Info = " ",
		}
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		local lspconfig = require("lspconfig")
		local opts = { noremap = true, silent = true }

		vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, opts)

		local custom_on_attach = function(_, bufnr)
			-- Mappings
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
			vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, bufopts)
			vim.keymap.set("n", "<leader>lf", vim.lsp.buf.formatting, bufopts)
			vim.keymap.set("n", "<leader>ac", vim.lsp.buf.code_action, bufopts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
		end

		-- Add additional capabilities supported by nvim-cmp
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		local default_flags = { debounce_text_changes = 150 }

		-- tsserver
		lspconfig["tsserver"].setup({
			on_attach = custom_on_attach,
			capabilities = capabilities,
			flags = default_flags,
		})

		-- gopls
		lspconfig["gopls"].setup({ on_attach = custom_on_attach, capabilities = capabilities, flags = default_flags })

		-- ccls
		lspconfig["ccls"].setup({
			init_options = {
				compilationDatabaseDirectory = "build",
			},
		})
		-- jsonls
		--nvim_lsp['jsonls'].setup {
		--  on_attach = custom_on_attach,
		--  capabilities = capabilities,
		--  flags = default_flags,
		--  settings = {
		--    json = {
		--      schemas = {
		--        -- Ref: https://github.com/neovim/nvim-lspconfig/issues/229#issuecomment-626439899
		--        {
		--          description = 'TypeScript compiler configuration file',
		--          fileMatch = {'tsconfig.json', 'tsconfig.*.json'},
		--          url = 'http://json.schemastore.org/tsconfig'
		--        },
		--        --{
		--        --  description = 'Lerna config',
		--        --  fileMatch = {'lerna.json'},
		--        --  url = 'http://json.schemastore.org/lerna'
		--        --},
		--        {
		--          description = 'Babel configuration',
		--          fileMatch = {'.babelrc.json', '.babelrc', 'babel.config.json'},
		--          url = 'http://json.schemastore.org/lerna'
		--        },
		--        {
		--          description = 'ESLint config',
		--          fileMatch = {'.eslintrc.json', '.eslintrc'},
		--          url = 'http://json.schemastore.org/eslintrc'
		--        },
		--        --{
		--        --  description = 'Bucklescript config',
		--        --  fileMatch = {'bsconfig.json'},
		--        --  url = 'https://bucklescript.github.io/bucklescript/docson/build-schema.json'
		--        --},
		--        {
		--          description = 'Prettier config',
		--          fileMatch = {'.prettierrc', '.prettierrc.json', 'prettier.config.json'},
		--          url = 'http://json.schemastore.org/prettierrc'
		--        },
		--        --{
		--        --  description = 'Vercel Now config',
		--        --  fileMatch = {'now.json'},
		--        --  url = 'http://json.schemastore.org/now'
		--        --},
		--        --{
		--        --  description = 'Stylelint config',
		--        --  fileMatch = {'.stylelintrc', '.stylelintrc.json', 'stylelint.config.json'},
		--        --  url = 'http://json.schemastore.org/stylelintrc'
		--        --},
		--      }
		--    },
		--  }
		--}

		-- lua_ls
		lspconfig["lua_ls"].setup({
			on_attach = custom_on_attach,
			capabilities = capabilities,
			flags = default_flags,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "use" },
					},
				},
			},
		})

		--for _, lsp in ipairs(servers) do
		--  nvim_lsp[lsp].setup {
		--    on_attach = custom_on_attach,
		--    capabilities = capabilities,
		--    flags = {
		--      debounce_text_changes = 150
		--    }
		--  }
		--end
	end,
	["LuaSnip"] = function()
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
	end,
	["trouble.nvim"] = function()
		require("trouble").setup()
	end,
	["null-ls"] = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting

		local sources = {
			formatting.stylua,
			formatting.prettierd,
		}

		-- Avoiding LSP formatting conflicts
		local lsp_formatting = function(bufnr)
			vim.lsp.buf.format({
				filter = function(client)
					return client.name == "null-ls"
				end,
				bufnr = bufnr,
			})
		end

		-- Using autogroup to set up formatting on save
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		require("null-ls").setup({
			sources = sources,
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							lsp_formatting(bufnr)
						end,
					})
				end
			end,
		})
	end,
	["nvim-cmp"] = function()
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		local cmp = require("cmp")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text", -- show only symbol annotations
					maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

					-- The function below will be called before any actual modifications from lspkind
					-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
					before = function(_, vim_item)
						return vim_item
					end,
				}),
			},
		})
	end,
}

return lsp
