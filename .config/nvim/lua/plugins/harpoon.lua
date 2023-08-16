return {
	"ThePrimeagen/harpoon",
	keys = {
		{
			"<leader>ha",
			function()
				require("harpoon.mark").add_file()
			end,
			desc = "Add file",
		},
		{
			"<leader>hh",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			desc = "Harpoon menu",
		},
		{
			"<leader>h[",
			function()
				require("harpoon.ui").nav_prev()
			end,
			desc = "Previous mark",
		},
		{
			"<leader>h]",
			function()
				require("harpoon.ui").nav_next()
			end,
			desc = "Next mark",
		},
	},
}
