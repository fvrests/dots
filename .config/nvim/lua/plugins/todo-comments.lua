require("todo-comments").setup({
	signs = false,
	keywords = {
		-- todo:
		TODO = { icon = "▨", color = "test", alt = { "todo" } },
		-- note:
		NOTE = { icon = ">", color = "hint", alt = { "note" } },
		-- info:
		INFO = { icon = "i", color = "info", alt = { "info" } },
		-- fix:
		FIX = { icon = "!", color = "error", alt = { "fix" } },
		-- hack:
		HACK = { icon = "*", color = "hint", alt = { "hack" } },
		-- perf:
		PERF = { icon = "~", color = "hint", alt = { "perf" } },
	},
	highlight = {
		comments_only = true,
		before = "fg",
		keyword = "fg",
		after = "",
	},
})

vim.keymap.set("n", "<leader>t", ":TodoTelescope initial_mode=normal theme=dropdown<cr>", { silent = true, desc = "Todos" })
vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { silent = true, desc = "Next todo" })
vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { silent = true, desc = "Previous todo" })
