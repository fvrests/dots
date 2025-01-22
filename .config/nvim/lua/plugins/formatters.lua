return {
	"stevearc/conform.nvim",
	config = function()
		local prettier = { "prettierd", "prettier", stop_after_first = true }
		require("conform").setup({
			notify_on_error = false,
			default_format_opts = { lsp_format = "fallback" },
			formatters_by_ft = {
				fish = { "fish_indent" },
				go = { "goimports" },
				rust = { "rustfmt" },

				-- prettier (default)
				javascript = prettier,
				javascriptreact = prettier,
				typescript = prettier,
				typescriptreact = prettier,
				vue = prettier,
				css = prettier,
				scss = prettier,
				less = prettier,
				html = prettier,
				json = prettier,
				jsonc = prettier,
				graphql = prettier,
				markdown = prettier,
				yaml = prettier,

				-- prettier (via extensions)
				astro = prettier,
				svelte = prettier,
			},
		})
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
			pattern = "*",
			callback = function()
				require("conform").format({ timeout_ms = 1000 })
			end,
		})
		vim.keymap.set("n", "<space><space>", vim.lsp.buf.format, { desc = "Format" })
	end,
}
