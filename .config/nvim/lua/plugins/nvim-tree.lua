return {
	"kyazdani42/nvim-tree.lua",
	keys = { { "<leader>e", ":NvimTreeFindFileToggle<cr>", desc = "Toggle file tree" } },
	opts = {
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		filters = {
			-- Hide ".git" folder.
			custom = { "^.git$" },
		},
		git = {
			-- Highlight based on git status
			enable = true,
			-- Do not hide gitignored files.
			ignore = false,
		},
		renderer = {
			-- Highlight based on git status
			highlight_git = true,
			icons = {
				-- Use custom folder icons.
				glyphs = {
					folder = {
						default = "●",
						open = "◌",
						empty = "━",
						empty_open = "═",
					},
				},
				-- Show folder tree icons only.
				show = {
					file = false,
					folder = true,
					folder_arrow = false,
					git = false,
				},
			},
		},
		trash = {
			cmd = "trash",
		},
		view = {
			side = "right",
		},
		on_attach = function(bufnr)
			local api = require("nvim-tree.api")
			api.config.mappings.default_on_attach(bufnr)
			vim.keymap.set("n", "d", api.fs.trash, { buffer = bufnr })
			vim.keymap.set("n", "D", api.fs.remove, { buffer = bufnr })
		end,
	},
}
