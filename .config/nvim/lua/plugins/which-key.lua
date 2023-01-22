return {
	"folke/which-key.nvim",
	config = function()
		require("which-key").setup({
			plugins = {
				spelling = {
					enabled = true,
				},
			},
		})
		require("which-key").register({ c = "Code", s = "Split" }, { prefix = "<leader>" })
	end,
}
