-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPre",
	dependencies = "nvim-lua/plenary.nvim",
	keys = { { "<space><space>", vim.lsp.buf.format, desc = "Format" } },
	config = function()
		local lsp_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		require("null-ls").setup({
			sources = {
				require("null-ls").builtins.formatting.fish_indent,
				require("null-ls").builtins.formatting.prettierd.with({
					extra_filetypes = { "jsonc", "astro", "svelte" },
				}),
				require("null-ls").builtins.formatting.shfmt,
				require("null-ls").builtins.formatting.stylua,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = lsp_augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = lsp_augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								bufnr = bufnr,
								filter = function(lsp_client)
									return lsp_client.name == "null-ls" or lsp_client.name == "denols"
								end,
							})
						end,
					})
				end
			end,
		})
	end,
}
