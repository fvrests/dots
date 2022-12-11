--- lil-extras.lua
--- https://github.com/mvllow/lilvim
---
--- Setup not so lil enhancements. This includes plugins to replace or improve
--- built-in functionality.

local use = require('lil-helpers').use

use({
	'folke/which-key.nvim',
	config = function()
		require('which-key').setup({
			plugins = {
				spelling = {
					enabled = true,
				},
			},
		})
		require('which-key').register(
			{ c = 'Code', s = 'Split' },
			{ prefix = '<leader>' }
		)
	end,
})

use({
	'kyazdani42/nvim-tree.lua',
	config = function()
		require('nvim-tree').setup({
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
			filters = {
				-- Hide ".git" folder.
				custom = { '^.git$' },
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
							default = '●',
							open = '◌',
							empty = '━',
							empty_open = '═',
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
				cmd = 'trash',
			},
			view = {
				mappings = {
					list = {
						-- Replace destructive default with trash command.
						{ key = 'd', action = 'trash' },
						{ key = 'D', action = 'remove' },
					},
				},
				side = 'right',
			},
		})
	end,
})

use({
	'folke/todo-comments.nvim',
	requires = 'nvim-lua/plenary.nvim',
	config = function()
		require('todo-comments').setup({
			signs = false,
			keywords = {
				-- TODO:
				TODO = { color = 'hint', alt = { 'todo' } },
				-- NOTE:
				NOTE = { color = 'warning', alt = { 'note' } },
				-- FIX:
				FIX = { color = 'default', alt = { 'fix' } },
				-- TEMP:
				TEMP = { color = 'info', alt = { 'temp' } },
			},
			gui_style = {
				fg = 'BOLD',
			},
			highlight = {
				before = 'fg',
				keyword = 'wide_fg',
				after = 'fg',
			},
		})
	end,
})

-- Toggle file tree at your current file.
vim.keymap.set(
	'n',
	'<leader>e',
	':NvimTreeFindFileToggle<cr>',
	{ silent = true, desc = 'Toggle file tree' }
)

-- Find todos
vim.keymap.set(
	'n',
	'<leader>t',
	':TodoTelescope<cr>',
	{ silent = true, desc = 'Todos' }
)
