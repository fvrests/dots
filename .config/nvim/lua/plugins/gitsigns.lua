return {
	"lewis6991/gitsigns.nvim",
	opts = {
		worktrees = {
			-- Dots bare repo
			{ toplevel = vim.env.HOME, gitdir = vim.env.HOME .. "/dots.git" },
		},
	},
}
