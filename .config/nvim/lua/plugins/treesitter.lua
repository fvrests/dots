return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = 'main',
	build = function()
		require 'nvim-treesitter'.install { "lua", "vimdoc", "markdown", "javascript", "typescript", "css", "html" }
		vim.cmd("TSUpdate")
	end,
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local filetype = args.match
				local lang = vim.treesitter.language.get_lang(filetype)
				if vim.tbl_contains(require("nvim-treesitter.config").get_available(), lang) then
					require("nvim-treesitter").install(lang):await(function()
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
						vim.treesitter.start()
					end)
				end
			end
		})
	end,
}
