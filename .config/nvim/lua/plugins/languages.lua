return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		{ "folke/neodev.nvim", config = true },
		{ "williamboman/mason.nvim", cmd = "Mason", config = true },
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
		capabilities.offsetEncoding = { "utf-16" }

		-- Automatically setup servers installed via Mason.
		-- @usage :MasonInstall <server>
		-- @example :MasonInstall denols tsserver
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				local opts = {}

				if server_name == "vue-language-server" then
					opts = {
						filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
					}
				end

				-- Remove shared root_dirs between deno and tsserver.
				-- https://deno.land/manual@v1.28.3/getting_started/setup_your_environment#neovim-06-using-the-built-in-language-server
				if server_name == "denols" then
					opts = {
						root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
					}
				end
				if server_name == "tsserver" then
					opts = {
						single_file_support = false,
						root_dir = require("lspconfig").util.root_pattern("package.json"),
					}
				end

				require("lspconfig")[server_name].setup(vim.tbl_deep_extend("force", {
					on_attach = on_attach,
					capabilities = capabilities,
				}, opts))
			end,
		})
	end,
}
