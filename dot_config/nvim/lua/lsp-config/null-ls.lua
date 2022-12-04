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
