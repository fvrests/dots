require("rose-pine").setup({
	highlight_groups = {
		NonText = { fg = "rose" },
		-- NormalFloat = { bg = "NONE" },
		NvimTreeFolderIcon = { fg = "gold" },
		NvimTreeFolderName = { fg = "text" },
		TelescopeBorder = { fg = "text", inherit = false },
		TodoBgNOTE = { fg = "base", bg = "gold" },
		TodoBgTODO = { fg = "base", bg = "rose" },
		TodoBgfix = { fg = "base", bg = "love" },
		TodoFgNOTE = { fg = "gold" },
		TodoFgTODO = { fg = "rose" },
		TodoFgfix = { fg = "love" },
	},
})

vim.cmd("colorscheme rose-pine")
