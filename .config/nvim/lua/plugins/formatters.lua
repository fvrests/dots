-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPre",
	dependencies = "nvim-lua/plenary.nvim",
	keys = { { "<space><space>", vim.lsp.buf.format, desc = "Format" } },
	config = function()
		local format_on_save = vim.api.nvim_create_augroup("FormatOnSave", {})
		require("null-ls").setup({
			sources = {
				require("null-ls").builtins.formatting.fish_indent,
				require("null-ls").builtins.formatting.prettierd.with({
					extra_filetypes = { "jsonc", "astro", "svelte" },
				}),
				require("null-ls").builtins.formatting.shfmt,
				require("null-ls").builtins.formatting.stylua,
				require("null-ls").builtins.formatting.rustfmt,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = format_on_save, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = format_on_save,
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
