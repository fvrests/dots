return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false,
	priority = 1000,
	config = function()
		require("rose-pine").setup({
			disable_float_background = true,
			highlight_groups = {
				TodoFgTODO = { fg = "rose" },
				TodoBgTODO = { fg = "base", bg = "rose" },
				TodoFgNOTE = { fg = "gold" },
				TodoBgNOTE = { fg = "base", bg = "gold" },
				TodoFgfix = { fg = "love" },
				TodoBgfix = { fg = "base", bg = "love" },
				-- TodoFgtemp = { fg = "foam" },
				-- TodoFginfo = { fg = "iris" },
				NvimTreeFolderName = { fg = "text" },
				TelescopeBorder = {
					fg = "text",
				},
				NvimTreeFolderIcon = {
					fg = "gold",
				},
			},
			-- disable_float_background = true,
		})
		vim.cmd("colorscheme rose-pine")
	end,
}
