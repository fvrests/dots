return {
	"nvim-telescope/telescope.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	keys = {
		{
			"<leader>f",
			":Telescope find_files theme=dropdown previewer=false<cr>",
			desc = "Find files",
		},
		{

			"<leader>r",
			":Telescope oldfiles find_command=fd,-t,f,-H,-E,.git,--strip-cwd-prefix theme=dropdown previewer=false initial_mode=normal only_cwd=true<cr>",
			desc = "Find files",
		},
		{

			"<leader>/",
			":Telescope live_grep layout_strategy=vertical layout_config={height=0.9}<cr>",
			desc = "Search",
		},
		{
			"<leader>p",
			":Telescope commands theme=dropdown<cr>",
			desc = "Command palette",
		},
	},
	config = true,
}
