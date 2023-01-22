return {
	"numToStr/Comment.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			-- Get comment string from treesitter. Useful for files with multiple
			-- languages, e.g. html `style` tags.
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
		})

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
