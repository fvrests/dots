require("gitsigns").setup({
	worktrees = {
		-- Dots bare repo
		{ toplevel = vim.env.HOME, gitdir = vim.env.HOME .. "/dots.git" },
	},
})

vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>gi", ":Gitsigns preview_hunk_inline<CR>", { desc = "Preview hunk (inline)" })
vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<cr>", { desc = "Blame current line" })
vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis<cr>", { desc = "Diff current file" })
vim.keymap.set({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>", { desc = "Undo stage hunk" })
vim.keymap.set("n", "<leader>gS", ":Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
vim.keymap.set({ "n", "v" }, "<leader>gR", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
vim.keymap.set({ "n", "v" }, "[h", ":Gitsigns nav_hunk prev<CR>", { desc = "Prev hunk" })
vim.keymap.set({ "n", "v" }, "]h", ":Gitsigns nav_hunk next<CR>", { desc = "Next hunk" })
