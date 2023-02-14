-- Number of items to show in popup menu.
vim.opt.pumheight = 10

-- Indentation levels.
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Persistent undo between sessions.
vim.opt.undofile = true

-- Natural split directions.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Start scrolling before reaching screen edge.
vim.opt.scrolloff = 10

-- Continue wrapped lines with matching indentation.
vim.opt.breakindent = true

-- Stop 'o' continuing comments.
vim.api.nvim_create_autocmd("BufEnter", {
	command = "setlocal formatoptions-=o",
})

-- Case-insensitive search, unless search contains uppercase.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable cursorline highlight.
vim.opt.cursorline = true

-- Always show sign column.
vim.opt.signcolumn = "yes"

-- Show line numbers.
vim.opt.number = true

-- Time in ms to update vim events.
vim.opt.updatetime = 250

-- Opioniated global statusline.
-- vim.opt.statusline = ' %f %m %= %l:%c ♥ '
-- vim.opt.laststatus = 3

-- Shorter vim messages.
vim.opt.shortmess:append("c")

-- Equally resize buffer splits.
vim.api.nvim_create_autocmd("VimResized", {
	command = "tabdo wincmd =",
})
