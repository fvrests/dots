return {
	"neovim/nvim-lspconfig",
	dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
	config = function()
		local server_opts = {
			denols = {
				root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
			},
			tsserver = {
				single_file_support = false,
				root_dir = require("lspconfig").util.root_pattern("package.json"),
				-- init_options = {
				-- 	plugins = {
				-- 		{
				-- 			name = "@vue/typescript-plugin",
				-- 			location = require("mason-registry").get_package("vue-language-server"):get_install_path()
				-- 					.. "/node_modules/@vue/language-server",
				-- 			languages = { "vue" },
				-- 		},
				-- 	},
				-- },
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			},
			lua_ls = {
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								"${3rd}/luv/library"
							},
						},
					},
				},
			},
		}

		local capabilities = vim.lsp.protocol.make_client_capabilities()

		--- Automatically setup servers installed via Mason.
		---@usage :MasonInstall <server>
		---@example :MasonInstall denols tsserver
		require("mason").setup({ ui = { border = "rounded" } })
		require("mason-lspconfig").setup({
			handlers = {
				function(server)
					local opts = server_opts[server] or {}
					opts.capabilities = capabilities
					require("lspconfig")[server].setup(opts)
				end,
			}
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("CustomLspAttach", { clear = false }),
			callback = function(args)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = true, desc = "Code actions" })
				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = true, desc = "Rename symbol" })

				vim.b.minicompletion_config = { lsp_completion = { source_func = "omnifunc", auto_setup = false } }
				vim.api.nvim_set_option_value("omnifunc", "v:lua.MiniCompletion.completefunc_lsp", { buf = args.buf })
			end
		})
	end,
}
