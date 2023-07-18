return {
	"iamcco/markdown-preview.nvim",
	ft = "markdown",
	build = "cd app && npm install",
	keys = {
		{
			"<leader>m",
			"<cmd>MarkdownPreviewToggle<cr>",
			desc = "Markdown Preview",
		},
	},
}
