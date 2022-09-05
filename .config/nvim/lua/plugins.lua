local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute('!git clone --depth 1 https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd([[
   augroup Packer
     autocmd!
     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
   augroup end
 ]])

require('packer').startup(function(use)
	use('wbthomason/packer.nvim')
	use('editorconfig/editorconfig-vim')
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
	use({
		'folke/which-key.nvim',
		config = function()
			require('which-key').setup({
				plugins = {
					presets = { operators = false },
				},
			})
			require('keymaps')
		end,
	})
	use({
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		requires = 'windwp/nvim-ts-autotag',
		config = function()
			require('nvim-treesitter.configs').setup({
				ensure_installed = 'all',
				--- phpdoc fails installing on m1
				ignore_install = { 'phpdoc' },
				autotag = { enable = true },
				highlight = { enable = true },
			})
		end,
	})
	use({
		'numToStr/Comment.nvim',
		requires = 'JoosepAlviste/nvim-ts-context-commentstring',
		config = function()
			require('comment').setup({
				toggler = {
					---Line-comment toggle keymap
					line = ',,',
				},
				opleader = {
					---Line-comment keymap
					line = ',',
				},
				extra = {
					---Add comment on the line above
					above = ',O',
					---Add comment on the line below
					below = ',o',
					---Add comment at the end of line
					eol = ',A',
				},
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
			})
			require('nvim-treesitter.configs').setup({
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
			})
		end,
	})
	use({
		'nvim-telescope/telescope.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('telescope').setup({
				defaults = { layout_config = { horizontal = { preview_width = 0.6 } } },
				pickers = {
					find_files = {
						find_command = { 'fd', '-t', 'f', '-H', '-E', '.git', '--strip-cwd-prefix' },
						theme = 'dropdown',
						previewer = false,
					},
					oldfiles = {
						only_cwd = true,
						find_command = { 'fd', '-t', 'f', '-H', '-E', '.git', '--strip-cwd-prefix' },
						theme = 'dropdown',
						previewer = false,
						initial_mode = 'normal',
					},
				},
			})
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
				filters = { custom = { '^.git$' } },
				git = { enable = true, ignore = false },
				renderer = {
					highlight_git = true,
					icons = {
						show = { folder = true, folder_arrow = false, file = false, git = false },
						glyphs = {
							folder = {
								default = '●',
								open = '◌',
								empty = '━',
								empty_open = '═',
							},
						},
					},
				},
				trash = {
					cmd = 'trash',
				},
				view = {
					mappings = {
						list = {
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
		'neovim/nvim-lspconfig',
		requires = 'folke/lua-dev.nvim',
		config = function()
			local function on_attach(client)
				client.resolved_capabilities.document_formatting = false
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

			local lspconfig = require('lspconfig')

			lspconfig.sumneko_lua.setup(require('lua-dev').setup({
				lspconfig = {
					on_attach = on_attach,
					capabilities = capabilities,
				},
			}))
			local signs = { Error = '● ', Warn = '● ', Hint = '● ', Info = '● ' }
			for type, icon in pairs(signs) do
				local hl = 'DiagnosticSign' .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
			vim.diagnostic.config({
				virtual_text = false,
			})

			local servers = {
				'html',
				'jsonls',
				'cssls',
				'tailwindcss',
				'tsserver',
				'volar',
				'svelte',
			}
			for _, server in ipairs(servers) do
				lspconfig[server].setup({ on_attach = on_attach, capabilities = capabilities })
			end
		end,
	})
	use({
		'jose-elias-alvarez/null-ls.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
		config = function()
			local null_ls = require('null-ls')
			local formatting = null_ls.builtins.formatting

			null_ls.setup({
				sources = {
					formatting.fish_indent,
					formatting.prettierd.with({ extra_filetypes = { 'svelte', 'jsonc', 'astro' } }),
					formatting.shfmt.with({ extra_filetypes = { 'bash', 'sh', 'zsh' } }),
					formatting.stylua,
				},
				on_attach = function(client)
					if client.resolved_capabilities.document_formatting then
						vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])
					end
				end,
			})
		end,
	})
	use({
		'hrsh7th/nvim-cmp',
		requires = { 'L3MON4D3/LuaSnip', 'hrsh7th/cmp-nvim-lsp' },
		config = function()
			local cmp = require('cmp')
			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				mapping = {
					['<c-space>'] = cmp.mapping.complete(),
					['<cr>'] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}),
					['<tab>'] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end,
					['<s-tab>'] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end,
				},
				sources = { { name = 'nvim_lsp' } },
			})
		end,
	})
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
							symbols = { error = '● ', warn = '● ', info = '● ', hint = '● ' },
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
	use({
		'folke/todo-comments.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('todo-comments').setup({
				signs = false,
				keywords = {
					-- TODO:
					TODO = { color = 'default', alt = { 'todo' } },
					-- NOTE:
					NOTE = { color = 'warning', alt = { 'note' } },
					-- FIX:
					FIX = { color = 'hint', alt = { 'fix' } },
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
end)
