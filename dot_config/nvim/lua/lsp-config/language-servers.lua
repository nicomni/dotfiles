local nvim_lsp = require("lspconfig")
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

-- local servers = { 'tsserver', 'sumneko_lua' }

local default_flags = { debounce_text_changes = 150 }

-- tsserver
nvim_lsp["tsserver"].setup({
	on_attach = custom_on_attach,
	capabilities = capabilities,
	flags = default_flags,
})

-- gopls
nvim_lsp["gopls"].setup({ on_attach = custom_on_attach, capabilities = capabilities, flags = default_flags })

-- ccls
nvim_lsp["ccls"].setup{
  init_options = {
    compilationDatabaseDirectory = "build";
  };
}
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

-- sumneko_lua
nvim_lsp["sumneko_lua"].setup({
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
