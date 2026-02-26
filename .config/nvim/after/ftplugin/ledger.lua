vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
	pattern = { "*.journal" },
	callback = function()
		vim.cmd("LedgerAlignBuffer")
	end,
})
