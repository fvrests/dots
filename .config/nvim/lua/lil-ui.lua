--- lil-ui.lua
--- https://github.com/mvllow/lilvim
---
--- Setup interface elements including colorscheme and statusline.

local use = require('lil-helpers').use

use({
	'nvim-treesitter/nvim-treesitter',
	run = ':TSUpdate',
	config = function()
		require('nvim-treesitter.configs').setup({
			-- Install treesitter parsers for all languages.
			ensure_installed = 'all',

			-- Enable treesitter syntax highlight groups.
			highlight = { enable = true },
		})
	end,
})

use({
	'rose-pine/neovim',
	as = 'rose-pine',
	config = function()
		require('rose-pine').setup({
			highlight_groups = {
				NvimTreeFolderName = { fg = 'text' },
				TelescopeBorder = {
					fg = 'text',
				},
				NvimTreeFolderIcon = {
					fg = 'gold',
				},
			},
		})
		vim.cmd('colorscheme rose-pine')
	end,
})

vim.diagnostic.config({
	-- Disable inline messages.
	virtual_text = false,
})

-- Use lil dots for diagnostic signs.
local signs = { 'Error', 'Warn', 'Hint', 'Info' }
for _, type in pairs(signs) do
	local hl = string.format('DiagnosticSign%s', type)
	vim.fn.sign_define(hl, { text = '●', texthl = hl, numhl = hl })
end

-- Enable cursorline highlight.
vim.opt.cursorline = true

-- Use block cursor in all modes.
vim.opt.guicursor = ''

-- Always show sign column.
vim.opt.signcolumn = 'yes'

-- Time in ms to update vim events.
vim.opt.updatetime = 250

-- Opioniated global statusline.
vim.opt.statusline = ' %f %m %= %l:%c ♥ '
vim.opt.laststatus = 3

-- Shorter vim messages.
vim.opt.shortmess:append('c')

-- Equally resize buffer splits.
vim.api.nvim_create_autocmd('VimResized', {
	command = 'tabdo wincmd =',
})
