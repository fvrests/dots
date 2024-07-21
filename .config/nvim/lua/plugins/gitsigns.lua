return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			worktrees = {
				-- Dots bare repo
				{ toplevel = vim.env.HOME, gitdir = vim.env.HOME .. "/dots.git" },
			},
		})
		vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<cr>", { desc = "Blame current line" })
	end,
}
