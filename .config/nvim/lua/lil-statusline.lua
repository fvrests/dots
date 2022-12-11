local use = require('lil-helpers').use
use({
	'nvim-lualine/lualine.nvim',
	config = function()
		local p = require('rose-pine.palette')
		vim.opt.showmode = false
		local filename = {
			'filename',
			symbols = {
				modified = '   ',
				readonly = ' ',
				unnamed = '',
			},
		}
		require('lualine').setup({
			options = {
				theme = 'rose-pine-alt',
				icons_enabled = false,
				component_separators = ' ',
				section_separators = ' ',
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { filename },
				lualine_c = {
					{
						'branch',
						fmt = function(branch)
							if branch == '' then
								return
							end
							return '(' .. branch .. ')'
						end,
						color = { fg = p.gold, gui = 'italic' },
					},
					{
						'diagnostics',
						symbols = {
							error = '● ',
							warn = '● ',
							info = '● ',
							hint = '● ',
						},
					},
				},
				lualine_x = {
					'diff',
				},
				lualine_y = { 'filetype' },
				lualine_z = { 'location' },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = { filename },
				lualine_c = {},
				lualine_x = { 'location' },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
})
