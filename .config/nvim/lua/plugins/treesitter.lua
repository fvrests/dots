return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			-- Install treesitter parsers for all languages.
			ensure_installed = { "lua", "vimdoc", "markdown" },
			auto_install = true,

			-- Enable treesitter syntax highlight groups.
			highlight = { enable = true },
		})
	end,
}
