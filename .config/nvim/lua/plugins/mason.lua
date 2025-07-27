vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("CustomLspAttach", { clear = false }),
	callback = function(args)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = true, desc = "Code actions" })
		vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = true, desc = "Rename symbol" })

		vim.b.minicompletion_config = { lsp_completion = { source_func = "omnifunc", auto_setup = false } }
		vim.api.nvim_set_option_value("omnifunc", "v:lua.MiniCompletion.completefunc_lsp", { buf = args.buf })
	end
});
return {
	"mason-org/mason-lspconfig.nvim",
	opts = {},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
}
