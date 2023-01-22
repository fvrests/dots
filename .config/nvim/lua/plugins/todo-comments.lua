return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	keys = { {
		"<leader>t",
		":TodoTelescope<cr>",
		desc = "Todos",
	} },
	opts = {
		signs = false,
		keywords = {
			-- todo:
			todo = { color = "hint", alt = { "todo" } },
			-- note:
			note = { color = "warning", alt = { "note" } },
			-- fix:
			fix = { color = "default", alt = { "fix" } },
			-- temp:
			temp = { color = "info", alt = { "temp" } },
		},
		gui_style = {
			fg = "bold",
		},
		highlight = {
			before = "fg",
			keyword = "wide_fg",
			after = "fg",
		},
	},
}
