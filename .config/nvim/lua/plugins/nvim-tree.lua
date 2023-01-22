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
			-- Use cross-platform trash command.
			-- https://github.com/sindresorhus/trash-cli
			cmd = "trash",
		},
		view = {
			mappings = {
				list = {
					-- Replace destructive default with trash command.
					{ key = "d", action = "trash" },
					{ key = "D", action = "remove" },
				},
			},
			side = "right",
		},
	},
}
