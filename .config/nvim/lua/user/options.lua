-- Number of items to show in popup menu.
vim.opt.pumheight = 10

-- Indentation levels.
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Persistent undo between sessions.
vim.o.undofile = true

-- Natural split directions.
vim.o.splitbelow = true
vim.o.splitright = true

-- Start scrolling before reaching screen edge.
vim.o.scrolloff = 4

-- Continue wrapped lines with matching indentation.
vim.o.breakindent = true

-- Case-insensitive search, unless search contains uppercase.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Enable cursorline highlight.
vim.o.cursorline = true

-- Always show sign column.
vim.o.signcolumn = "yes"

-- Time in ms to update vim events.
vim.o.updatetime = 250

-- Stop 'o' continuing comments.
vim.api.nvim_create_autocmd("BufEnter", {
	command = "setlocal formatoptions-=o",
})

-- Equally resize buffer splits.
vim.api.nvim_create_autocmd("VimResized", {
	command = "tabdo wincmd =",
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "⏺",
			[vim.diagnostic.severity.WARN] = "⏺",
			[vim.diagnostic.severity.INFO] = "⏺",
			[vim.diagnostic.severity.HINT] = "⏺",
		},
	},
	virtual_text = false,
})
