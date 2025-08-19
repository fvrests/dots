require("telescope").setup()

vim.keymap.set("n", "<leader>f", ":Telescope find_files theme=dropdown previewer=false<cr>",
	{ silent = true, desc = "Find files" })
vim.keymap.set("n", "<leader>r",
	":Telescope oldfiles find_command=fd,-t,f,-H,-E,.git,--strip-cwd-prefix theme=dropdown previewer=false initial_mode=normal only_cwd=true<cr>",
	{ silent = true, desc = "Recent files" })
vim.keymap.set("n", "<leader>/", ":Telescope live_grep layout_strategy=vertical layout_config={height=0.9}<cr>",
	{ silent = true, desc = "Search" })
vim.keymap.set("n", "<leader>p", ":Telescope commands theme=dropdown<cr>", { silent = true, desc = "Command palette" })
