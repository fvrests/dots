return {
	"folke/which-key.nvim",
	config = function()
		require("which-key").setup({
			preset = "helix",
			sort = { "alphanum", "order", "mod" },
			plugins = {
				spelling = {
					enabled = true,
				},
				presets = {
					operators = false,
				},
			},
			icons = {
				mappings = false,
				separator = "→",
			},
		})
		require("which-key").add({
			{ "<leader>\\", desc = "Matcha" },
			{ "<leader>c",  desc = "Code" },
			{ "<leader>g",  desc = "Gitsigns" },
			{ "<leader>h",  desc = "Harpoon" },
			{ "<leader>s",  desc = "Split" },
			{ "<leader>u",  desc = "UI" },
		})
	end,
}
