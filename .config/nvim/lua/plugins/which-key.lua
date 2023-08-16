return {
	"folke/which-key.nvim",
	config = function()
		require("which-key").setup({
			plugins = {
				spelling = {
					enabled = true,
				},
				presets = {
					operators = false,
				},
			},
		})
		require("which-key").register({ c = "Code", h = "Harpoon", s = "Split", u = "UI" }, { prefix = "<leader>" })
	end,
}
