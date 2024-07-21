return {
	"stevearc/conform.nvim",
	event = "BufReadPre",
	keys = { { "<space><space>", vim.lsp.buf.format, desc = "Format" } },
	config = function()
		require("conform").setup({
			notify_on_error = false,
			formatters_by_ft = {
				fish = { "fish_indent" },
				go = { "goimports" },
				lua = { "stylua" },
				rust = { "rustfmt" },

				-- prettier (default)
				javascript = { { "prettierd", "prettier" } },
				javascriptreact = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				vue = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				scss = { { "prettierd", "prettier" } },
				less = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				jsonc = { { "prettierd", "prettier" } },
				graphql = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" } },
				yaml = { { "prettierd", "prettier" } },

				-- prettier (via extensions)
				astro = { { "prettierd", "prettier" } },
				svelte = { { "prettierd", "prettier" } },
			},
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
			pattern = "*",
			callback = function(args)
				require("conform").format({
					bufnr = args.buf,
					lsp_fallback = true,
				})
			end,
		})
	end,
}
