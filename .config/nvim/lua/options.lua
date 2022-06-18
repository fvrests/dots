-- vim.opt.title = true
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.shortmess:append('c')
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 10
vim.opt.signcolumn = 'yes'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.pumheight = 10
vim.opt.wrap = true
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·' }
vim.opt.timeoutlen = 1500
vim.opt.cursorline = true
vim.opt.list = false
vim.opt.listchars = { tab = '┊ ', space = '·', trail = '·' }

vim.cmd('autocmd BufEnter * setlocal formatoptions-=o')
vim.cmd('autocmd VimResized * tabdo wincmd =')
vim.cmd('autocmd BufRead,BufNewFile *.json set ft=jsonc')
