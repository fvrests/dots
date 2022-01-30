local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone --depth 1 https://github.com/wbthomason/packer.nvim " .. install_path)
end

local p = require("rose-pine.palette")

require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("editorconfig/editorconfig-vim")
	use({
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			local p = require("rose-pine.palette")
			vim.g.rose_pine_colors = { border = p.text }
			vim.cmd("colorscheme rose-pine")
		end,
	})
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				presets = { operators = false },
			})
			require("keymaps")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = "windwp/nvim-ts-autotag",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "maintained",
				ignore_install = { "haskell" },
				indent = { enable = true },
				autotag = { enable = true },
				highlight = { enable = true },
			})
		end,
	})
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	})
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("comment").setup({
				toggler = {
					---Line-comment toggle keymap
					line = ",,",
				},
				opleader = {
					---Line-comment keymap
					line = ",",
				},
				extra = {
					---Add comment on the line above
					above = ",O",
					---Add comment on the line below
					below = ",o",
					---Add comment at the end of line
					eol = ",A",
				},
			})
		end,
	})
	use({
		"nvim-telescope/telescope.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("telescope").setup({
				defaults = { layout_config = { horizontal = { preview_width = 0.6 } } },
				pickers = { find_files = { theme = "dropdown", previewer = false, initial_mode = "normal" } },
			})
		end,
	})
	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			vim.g.nvim_tree_icons = {
				folder = { default = ">", empty = ">", empty_open = "▼", open = "▼" },
			}
			vim.g.nvim_tree_quit_on_open = 1
			vim.g.nvim_tree_show_icons = { folders = 1, files = 0 }
			require("nvim-tree").setup({
				auto_close = true,
				filters = { custom = { ".git" } },
				git = { ignore = false },
				view = { side = "right" },
			})
		end,
	})
	use({
		"neovim/nvim-lspconfig",
		requires = "folke/lua-dev.nvim",
		config = function()
			local function on_attach(client)
				client.resolved_capabilities.document_formatting = false
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

			local lspconfig = require("lspconfig")

			lspconfig.sumneko_lua.setup(require("lua-dev").setup({
				lspconfig = {
					on_attach = on_attach,
					capabilities = capabilities,
				},
			}))
			local signs = { Error = "● ", Warn = "● ", Hint = "● ", Info = "● " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
				},
			})

			local servers = {
				"html",
				"jsonls",
				"cssls",
				"tailwindcss",
				"tsserver",
				"volar",
				"svelte",
			}
			for _, server in ipairs(servers) do
				lspconfig[server].setup({ on_attach = on_attach, capabilities = capabilities })
			end
		end,
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting

			null_ls.setup({
				sources = {
					formatting.fish_indent,
					formatting.prettierd.with({ extra_filetypes = { "svelte", "jsonc" } }),
					formatting.shfmt.with({ extra_filetypes = { "bash", "sh", "zsh" } }),
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
		"hrsh7th/nvim-cmp",
		requires = { "L3MON4D3/LuaSnip", "hrsh7th/cmp-nvim-lsp", "windwp/nvim-autopairs" },
		config = function()
			local cmp = require("cmp")
			cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = {
					["<c-space>"] = cmp.mapping.complete(),
					["<cr>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}),
					["<tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end,
					["<s-tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end,
				},
				sources = { { name = "nvim_lsp" } },
			})
		end,
	})
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			local p = require("rose-pine.palette")
			require("lualine").setup({
				options = {
					icons_enabled = false,
					theme = {
						normal = {
							a = { bg = p.overlay, fg = p.rose, gui = "bold" },
							b = { bg = p.overlay, fg = p.text },
							c = { bg = p.overlay, fg = p.subtle },
						},
						insert = {
							a = { bg = p.overlay, fg = p.foam, gui = "bold" },
							b = { bg = p.overlay, fg = p.text },
							c = { bg = p.overlay, fg = p.subtle },
						},
						visual = {
							a = { bg = p.overlay, fg = p.iris, gui = "bold" },
							b = { bg = p.overlay, fg = p.text },
							c = { bg = p.overlay, fg = p.subtle },
						},
						replace = {
							a = { bg = p.overlay, fg = p.pine, gui = "bold" },
							b = { bg = p.overlay, fg = p.text },
							c = { bg = p.overlay, fg = p.subtle },
						},
						command = {
							a = { bg = p.overlay, fg = p.love, gui = "bold" },
							b = { bg = p.overlay, fg = p.text },
							c = { bg = p.overlay, fg = p.subtle },
						},
						inactive = {
							a = { bg = p.base, fg = p.subtle, gui = "bold" },
							b = { bg = p.base, fg = p.subtle },
							c = { bg = p.base, fg = p.subtle },
						},
					},
					component_separators = " ",
					section_separators = " ",
					always_divide_middle = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "filename" },
					lualine_c = { "branch", "diff", "diagnostics" },
					lualine_x = {},
					lualine_y = { "filetype" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = { "filename" },
					lualine_c = {},
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	})
end)
