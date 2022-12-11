--- lil-search.lua
--- https://github.com/mvllow/lilvim
---
--- Setup search.

local use = require('lil-helpers').use

use({
	'nvim-telescope/telescope.nvim',
	requires = 'nvim-lua/plenary.nvim',
	config = function()
		require('telescope').setup({})
	end,
})

use({
	'windwp/nvim-spectre',
	config = function()
		require('spectre').setup({
			mapping = {
				['send_to_qf'] = {
					map = 'q',
					cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
					desc = 'send all item to quickfix',
				},
			},
		})
	end,
})

-- Case-insensitive search, unless search contains uppercase.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Clear search highlights.
vim.keymap.set('n', '<esc>', ':noh<cr>', { silent = true, desc = 'Clear search highlights' })

-- Keep position when searching for word under cursor.
vim.keymap.set('n', '*', '*N', { silent = true, desc = 'Search hovered word' })
vim.keymap.set('v', '*', [[y/\V<c-r>=escape(@",'/\')<cr><cr>N]], { silent = true, desc = 'Search hovered word' })

-- Replace (allows n + . to replace more matches).
vim.keymap.set('n', '&', '*Ncgn', { silent = true, desc = 'Replace (repeatable)' })
vim.keymap.set('v', '&', [[y/\V<c-r>=escape(@",'/\')<cr><cr>Ncgn]], { silent = true, desc = 'Replace (repeatable)' })

-- Find files
vim.keymap.set(
	'n',
	'<leader>f',
	':Telescope find_files find_command=fd,-t,f,-H,-E,.git,--strip-cwd-prefix theme=dropdown previewer=false<cr>',
	{ silent = true, desc = 'Find files' }
)

-- Reopen files
vim.keymap.set(
	'n',
	'<leader>r',
	':Telescope oldfiles find_command=fd,-t,f,-H,-E,.git,--strip-cwd-prefix theme=dropdown previewer=false initial_mode=normal only_cwd=true<cr>'
	,
	{ silent = true, desc = 'Find files' }
)

-- Find text
vim.keymap.set('n', '<leader>/', ':Telescope live_grep<cr>', { silent = true, desc = 'Search' })

-- Command palette
vim.keymap.set('n', '<leader>p', ':Telescope commands theme=dropdown<cr>', { silent = true, desc = 'Command palette' })

-- Spectre
vim.keymap.set('n', '<leader>cs', function()
	require('spectre').open_visual({ select_word = true })
end, { silent = true, desc = 'Spectre' })
