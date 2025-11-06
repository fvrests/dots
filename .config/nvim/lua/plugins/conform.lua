require("conform").setup({
	notify_on_error = false,
	default_format_opts = { lsp_format = "fallback" },
	formatters_by_ft = {
		fish = { "fish_indent" },
		go = { "goimports" },
		rust = { "rustfmt" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		vue = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		less = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		graphql = { "prettier" },
		markdown = { "prettier" },
		yaml = { "prettier" },
		astro = { "prettier" },
		svelte = { "prettier" },
		ruby = { "rubocop" },
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
