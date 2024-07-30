return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			worktrees = {
				-- Dots bare repo
				{ toplevel = vim.env.HOME, gitdir = vim.env.HOME .. "/dots.git" },
			},
		})
		vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
		vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<cr>", { desc = "Blame current line" })
		vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis<cr>", { desc = "Diff current file" })
		vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
		vim.keymap.set("v", "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
		vim.keymap.set("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "Undo stage hunk" })
		vim.keymap.set("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
		vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
		vim.keymap.set("v", "<leader>gR", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
		vim.keymap.set("n", "]g", "&diff ? ']g' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
		vim.keymap.set("n", "[g", "&diff ? '[g' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
	end,
}
