return {
	"echasnovski/mini.comment",
	config = function()
		require("mini.comment").setup({
			mappings = {
				comment = ",",
				comment_line = ",,",
				comment_visual = ","
			}
		})
	end,
}
