local function map(mode, key, action, options)
	options = options or {}
	if options.silent == nil then
		options.silent = true
	end
	vim.keymap.set(mode, key, action, options)
end

vim.g.mapleader = " "

map("n", "<leader>q", ":q<cr>", { desc = "Quit" })
map("n", "<leader>w", ":w<cr>", { desc = "Save" })

map({ "n", "v" }, "<leader>y", '"*y', { silent = false, desc = "Yank to system clipboard" })
map("n", "S", ":%s/<c-r><c-w>//g<left><left>", { desc = "Substitute current word (regex)", silent = false })

-- Splits
map("n", "<leader>j", "<c-w><c-w>", { desc = "Next split" })
map("n", "<leader>sl", ":vsplit<cr>", { desc = "Vertical" })
map("n", "<leader>sj", ":split<cr>", { desc = "Horizontal" })
map("n", "<leader>so", ":only<cr>", { desc = "Only (close other splits)" })

-- Move in buffer
map({ "n", "v" }, "j", "gj", { desc = "Move down wrapped lines" })
map({ "n", "v" }, "k", "gk", { desc = "Move up wrapped lines" })
map({ "n", "v" }, "gm", "%", { desc = "Goto matching pair" })
map("n", "<c-j>", ":m .+1<cr>==", { desc = "Bubble line down" })
map("n", "<c-k>", ":m .-2<cr>==", { desc = "Bubble line up" })
map("v", "<c-j>", ":m '>+1<cr>gv=gv", { desc = "Bubble line down" })
map("v", "<c-k>", ":m '<-2<cr>gv=gv", { desc = "Bubble line up" })

-- Goto
map("n", "[p", "<c-o>", { desc = "Previous position" })
map("n", "]p", "<c-i>", { desc = "Next position" })
map("n", "[b", ":bp", { desc = "Previous buffer" })
map("n", "]b", ":bn", { desc = "Next buffer" })
map("n", "[f", "<c-^>", { desc = "Previous focused buffer" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Show line diagnostics.
map("n", "<leader>k", vim.diagnostic.open_float, { desc = "Diagnostics" })

-- Set diagnostics into quickfix.
map("n", "<leader>d", vim.diagnostic.setloclist, { desc = "Send diagnostics to quickfix" })

-- Clear search highlights.
vim.keymap.set("n", "<esc>", ":noh<cr>", { silent = true, desc = "Clear search highlights" })

-- Keep position when searching for word under cursor.
vim.keymap.set("n", "*", "*N", { silent = true, desc = "Search hovered word" })
vim.keymap.set("v", "*", [[y/\V<c-r>=escape(@",'/\')<cr><cr>N]], { silent = true, desc = "Search hovered word" })

-- Replace (allows n + . to replace more matches).
vim.keymap.set("n", "&", "*Ncgn", { silent = true, desc = "Replace (repeatable)" })
vim.keymap.set("v", "&", [[y/\V<c-r>=escape(@",'/\')<cr><cr>Ncgn]], { silent = true, desc = "Replace (repeatable)" })

-- Toggle scrolloff
local function toggle_scrolloff()
	local scrolloff = vim.api.nvim_win_get_option(0, "scrolloff")
	vim.api.nvim_win_set_option(0, "scrolloff", scrolloff == 0 and 5 or 0)
end

vim.keymap.set("n", "<leader>us", toggle_scrolloff, { silent = true, desc = "Toggle scrolloff" })
