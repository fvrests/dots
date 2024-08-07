return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false,
	priority = 1000,
	config = function()
		require("rose-pine").setup({
			highlight_groups = {
				NormalFloat = { bg = "NONE" },
				TodoFgTODO = { fg = "rose" },
				TodoBgTODO = { fg = "base", bg = "rose" },
				TodoFgNOTE = { fg = "gold" },
				TodoBgNOTE = { fg = "base", bg = "gold" },
				TodoFgfix = { fg = "love" },
				TodoBgfix = { fg = "base", bg = "love" },
				NvimTreeFolderName = { fg = "text" },
				TelescopeBorder = {
					fg = "text",
					inherit = false,
				},
				NvimTreeFolderIcon = {
					fg = "gold",
				},
			},
		})
		vim.cmd("colorscheme rose-pine")
	end,
}
