require("fvrests/keymaps")
require("fvrests/options")

--- Manage packages
--- Update via `:=vim.pack.update()`
--- :help vim.pack
vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/ThePrimeagen/harpoon" },
	{ src = "https://github.com/rose-pine/neovim",                name = "rose-pine" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/mvllow/matcha.nvim",              version = "canary" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/mvllow/modes.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/vim-test/vim-test" },
	-- { src = "https://github.com/folke/which-key.nvim" },
})

-- On package update
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function()
		vim.cmd("TSUpdate")
	end
})

require("plugins/conform")
require("plugins/gitsigns")
require("plugins/harpoon")
require("plugins/mason")
require("plugins/matcha")
require("plugins/mini-clue")
require("plugins/mini-completion")
require("plugins/rose-pine")
require("plugins/modes")
require("plugins/telescope")
require("plugins/todo-comments")
require("plugins/tree")
require("plugins/treesitter")
