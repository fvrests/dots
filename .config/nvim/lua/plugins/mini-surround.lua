-- fix: only 'sa' seems to work. should provide 'sd', 'sr', etc
-- https://github.com/echasnovski/mini.surround

return {
	"echasnovski/mini.surround",
	event = "BufReadPre",
	config = function()
		require("mini.surround").setup({})
	end,
}
