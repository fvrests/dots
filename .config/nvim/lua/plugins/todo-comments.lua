return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	cmd = { "TodoQuickFix", "TodoTelescope" },
	event = "BufReadPost",
	keys = {
		{
			"<leader>t",
			"<cmd>TodoTelescope<cr>",
			desc = "Todos",
		},
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next todo",
		},
		{

			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Previous todo",
		},
	},
	opts = {
		signs = false,
		keywords = {
			-- todo:
			TODO = { icon = "▨", color = "test", alt = { "todo" } },
			-- note:
			NOTE = { icon = ">", color = "hint", alt = { "note" } },
			-- info:
			INFO = { icon = "i", color = "info", alt = { "info" } },
			-- fix:
			FIX = { icon = "!", color = "default", alt = { "fix" } },
		},
		highlight = {
			comments_only = true,
			before = "fg",
			keyword = "fg",
			after = "fg",
		},
	},
}
