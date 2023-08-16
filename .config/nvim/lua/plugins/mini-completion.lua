return {
	"echasnovski/mini.completion",
	lazy = false,
	event = "BufReadPre",
	-- keys = {
	-- 	{
	-- 		"<cr>",
	-- 		function()
	-- 			local keys = {
	-- 				["cr"] = vim.api.nvim_replace_termcodes("<cr>", true, true, true),
	-- 				["c-y"] = vim.api.nvim_replace_termcodes("<c-y>", true, true, true),
	-- 				["c-y_cr"] = vim.api.nvim_replace_termcodes("<c-y><cr>", true, true, true),
	-- 			}
	--
	-- 			if vim.fn.pumvisible() ~= 0 then
	-- 				local item_selected = vim.fn.complete_info()["selected"] ~= -1
	-- 				return item_selected and keys["c-y"] or keys["c-y_cr"]
	-- 			else
	-- 				return keys["cr"]
	-- 			end
	-- 		end,
	-- 		mode = "i",
	-- 		expr = true,
	-- 	},
	-- 	{
	-- 		"<tab>",
	-- 		"pumvisible() ? '<c-n>' : '<tab>'",
	-- 		mode = "i",
	-- 		expr = true,
	-- 	},
	-- 	{
	-- 		"<s-tab>",
	-- 		"pumvisible() ? '<c-p>' : '<s-tab>'",
	-- 		mode = "i",
	-- 		expr = true,
	-- 	},
	-- },
	config = function()
		vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
		vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
		local keys = {
			["cr"] = vim.api.nvim_replace_termcodes("<CR>", true, true, true),
			["ctrl-y"] = vim.api.nvim_replace_termcodes("<C-y>", true, true, true),
			["ctrl-y_cr"] = vim.api.nvim_replace_termcodes("<C-y><CR>", true, true, true),
		}
		vim.keymap.set("i", "<cr>", function()
			return vim.fn.pumvisible() ~= 0
					and (vim.fn.complete_info()["selected"] ~= 1 and keys["ctrl-y"] or keys["ctrl-y_cr"])
				or keys["cr"]
		end, { expr = true })

		require("mini.completion").setup({ lsp_completion = { source_func = "omnifunc", auto_setup = false } })
	end,
}
