return {
	"numToStr/Comment.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		require("ts_context_commentstring").setup({})

		require("Comment").setup({
			toggler = {
				---Line-comment toggle keymap
				line = ",,",
			},
			opleader = {
				---Line-comment keymap
				line = ",",
			},
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}
