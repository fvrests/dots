return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false,
	priority = 1000,
	config = function()
		require("rose-pine").setup({
			highlight_groups = {
				NvimTreeFolderName = { fg = "text" },
				TelescopeBorder = {
					fg = "text",
				},
				NvimTreeFolderIcon = {
					fg = "gold",
				},
			},
			disable_float_background = true,
		})
		vim.cmd("colorscheme rose-pine")
	end,
}
