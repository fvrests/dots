return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		{ "williamboman/mason.nvim", cmd = "Mason", opts = {
			ui = {
				border = "rounded",
			},
		} },
		{ "williamboman/mason-lspconfig.nvim", config = true },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim", opts = {} },
	},
	config = function()
		-- Use lil dots for diagnostic signs.
		local signs = { "Error", "Warn", "Hint", "Info" }
		for _, type in pairs(signs) do
			local hl = string.format("DiagnosticSign%s", type)
			vim.fn.sign_define(hl, { text = "●", texthl = hl, numhl = hl })
		end
		vim.diagnostic.config({
			-- Disable inline messages.
			virtual_text = false,
		})
		local function on_attach(_, bufnr)
			local function map(mode, key, action, options)
				options = options or {}
				options.buffer = options.buffer or bufnr
				options.silent = options.silent or true
				vim.keymap.set(mode, key, action, options)
			end
			vim.b.minicompletion_config = {
				lsp_completion = {
					source_func = "omnifunc",
					auto_setup = false,
				},
			}
			vim.api.nvim_set_option_value("omnifunc", "v:lua.MiniCompletion.completefunc_lsp", { buf = bufnr })

			map("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
			map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
			map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
			map("n", "K", vim.lsp.buf.hover, { desc = "Documentation" })
			map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
			map("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
			map("n", "gt", vim.lsp.buf.type_definition, { desc = "Goto type definition" })
			map("n", "gi", vim.lsp.buf.implementation, { desc = "Goto implementation" })
			map("n", "gr", vim.lsp.buf.references, { desc = "Goto references" })
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()

		local mason_registry = require("mason-registry")
		local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
			.. "/node_modules/@vue/language-server"

		local server_opts = {
			denols = {
				root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
			},
			tsserver = {
				single_file_support = false,
				root_dir = require("lspconfig").util.root_pattern("package.json"),
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_language_server_path,
							languages = { "vue" },
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			},
			lua_ls = {
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME },
						},
					},
				},
			},
		}

		-- Automatically setup servers installed via Mason.
		-- @usage :MasonInstall <server>
		-- @example :MasonInstall denols tsserver
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				local server = server_opts[server_name] or {}
				server.capabilities = capabilities
				server.on_attach = on_attach
				require("lspconfig")[server_name].setup(server)
			end,
		})
	end,
}
