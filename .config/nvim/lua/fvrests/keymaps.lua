vim.g.mapleader = " "

vim.keymap.set("n", "<leader>q", ":q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>w", ":w<cr>", { desc = "Save" })

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })

vim.keymap.set("n", "S", ":%s/<c-r><c-w>//g<left><left>", { desc = "Substitute current word (regex)" })

-- Splits
vim.keymap.set("n", "<leader>j", "<c-w><c-w>", { desc = "Next split" })
vim.keymap.set("n", "<leader>sl", ":vsplit<cr>", { desc = "Vertical" })
vim.keymap.set("n", "<leader>sj", ":split<cr>", { desc = "Horizontal" })
vim.keymap.set("n", "<leader>so", ":only<cr>", { desc = "Only (close other splits)" })

-- Move in buffer
vim.keymap.set({ "n", "v" }, "j", "gj", { desc = "Move down wrapped lines" })
vim.keymap.set({ "n", "v" }, "k", "gk", { desc = "Move up wrapped lines" })
vim.keymap.set("n", "<c-j>", ":m .+1<cr>==", { desc = "Bubble line down" })
vim.keymap.set("n", "<c-k>", ":m .-2<cr>==", { desc = "Bubble line up" })
vim.keymap.set("v", "<c-j>", ":m '>+1<cr>gv=gv", { desc = "Bubble line down" })
vim.keymap.set("v", "<c-k>", ":m '<-2<cr>gv=gv", { desc = "Bubble line up" })

-- Goto
vim.keymap.set("n", "[p", "<c-o>", { desc = "Previous position" })
vim.keymap.set("n", "]p", "<c-i>", { desc = "Next position" })
vim.keymap.set("n", "[b", ":bp", { desc = "Previous buffer" })
vim.keymap.set("n", "]b", ":bn", { desc = "Next buffer" })
vim.keymap.set("n", "[f", "<c-^>", { desc = "Previous focused buffer" })

-- Show line diagnostics
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, { desc = "Diagnostics" })

-- Clear search highlights
vim.keymap.set("n", "<esc>", ":noh<cr>", { silent = true, desc = "Clear search highlights" })

-- Replace (allows n + . to replace more matches)
vim.keymap.set("n", "&", "*Ncgn", { desc = "Replace (repeatable)" })
vim.keymap.set("v", "&", [[y/\V<c-r>=escape(@",'/\')<cr><cr>Ncgn]], { desc = "Replace (repeatable)" })

-- Comments
vim.keymap.set("v", ",", "gc", { remap = true })
vim.keymap.set("n", ",,", function()
	if vim.fn.getline("."):match("^%s*$") then
		local pos = vim.bo.commentstring:find("%%s")
		local comment = vim.bo.commentstring:gsub("%%s", "")
		vim.api.nvim_put({ comment }, "", false, false)
		vim.cmd("startinsert")
		vim.api.nvim_win_set_cursor(0, { vim.fn.line("."), pos - 1 })
	else
		vim.cmd("normal gcc")
	end
end)
