require("mini.files").setup({
	options = { permanent_delete = false },
	mappings = {
		go_in_plus = "<cr>",
	}
})
vim.keymap.set("n", "<leader>e", function()
	require("mini.files").open(vim.api.nvim_buf_get_name(0))
end, { desc = "Explorer" })
