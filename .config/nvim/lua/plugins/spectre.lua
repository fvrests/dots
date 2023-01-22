return {
	"windwp/nvim-spectre",
	keys = {
		{
			"<leader>cs",
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			desc = "Spectre",
		},
	},
	opts = {
		mapping = {
			["send_to_qf"] = {
				map = "q",
				cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
				desc = "send all item to quickfix",
			},
		},
	},
}
