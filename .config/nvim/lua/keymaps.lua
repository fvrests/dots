-- vim.keymap.set(mode, new keymap, default keymap, options)

-- set leader
vim.g.mapleader = ' '
vim.keymap.set('n', '<space>', '<nop>', { silent = true })

-- natural j/k
vim.keymap.set({ 'n', 'v' }, 'j', 'gj', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'k', 'gk', { silent = true })

-- esc to hide matches
vim.keymap.set('n', '<esc>', ':noh<cr>', { silent = true })

-- bubble
vim.keymap.set('n', '<c-j>', ':m .+1<cr>==', { silent = true })
vim.keymap.set('n', '<c-k>', ':m .-2<cr>==', { silent = true })
vim.keymap.set('v', '<c-j>', ":m '>+1<cr>gv=gv", { silent = true })
vim.keymap.set('v', '<c-k>', ":m '<-2<cr>gv=gv", { silent = true })

-- indent
vim.keymap.set('v', '<c-h>', '<gv', { silent = true })
vim.keymap.set('v', '<c-l>', '>gv', { silent = true })

-- find:
-- just find matches
vim.keymap.set('n', '*', '*N', { silent = true })
vim.keymap.set('v', '*', [[y/\V<c-r>=escape(@",'/\')<cr><cr>N]], { silent = true })
-- replace (allows n + . to replace more matches)
vim.keymap.set('n', '&', '*Ncgn', { silent = true })
vim.keymap.set('v', '&', [[y/\V<c-r>=escape(@",'/\')<cr><cr>Ncgn]], { silent = true })

-- yank to clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"*y')

-- info:
-- hover
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true })
-- functions
vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, { silent = true })

-- go to:
-- definition
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { silent = true })
-- previous position
vim.keymap.set('n', 'go', '<c-o>', { silent = true })
-- next position
vim.keymap.set('n', 'gO', '<c-i>', { silent = true })
-- references
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { silent = true })
-- diagnostic
vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, { silent = true })

local function format()
	vim.cmd('!prettierd restart')
	vim.lsp.buf.format()
	vim.cmd('w')
end

local mappings = {
	['/'] = { ':Telescope live_grep<cr>', 'find text (global)' },
	c = {
		name = 'code',
		a = { vim.lsp.buf.code_action, 'actions' },
		f = { format, 'format and save' },
		r = { vim.lsp.buf.rename, 'rename' },
		s = {
			function()
				require('spectre').open_visual({ select_word = true })
			end,
			'spectre',
		},
	},
	e = { ':NvimTreeFindFileToggle<cr>', 'explorer' },
	f = { ':Telescope find_files<cr>', 'find files' },
	h = { ':Telescope help_tags<cr>', 'help' },
	j = { '<c-w><c-w>', 'next split' },
	k = { vim.diagnostic.open_float, 'show diagnostics' },
	m = { ':Mason<cr>', 'Mason' },
	q = { ':q<cr>', 'quit' },
	r = { ':Telescope oldfiles<cr>', 'reopen files' },
	w = { ':w<cr>', 'save' },
	y = { 'yank to clipboard' },
	p = {
		name = 'plugins',
		c = { ':PackerCompile<cr>', 'compile' },
		s = { ':PackerSync<cr>', 'sync' },
	},
	s = {
		name = 'split',
		l = { ':vsplit<cr>', 'vertical' },
		j = { ':split<cr>', 'horizontal' },
		o = { ':only<cr>', 'only (close other splits)' },
	},
	t = { ':TodoTelescope<cr>', 'todos' },
}

local g = {
	d = { 'definition' },
	o = { 'previous position' },
	O = { 'next position' },
	r = { 'references' },
	['['] = { 'previous diagnostic' },
	[']'] = { 'next diagnostic' },
}

local comments = {
	[','] = { 'comment current line' },
	A = { 'append comment' },
	O = { 'comment previous line' },
	o = { 'comment next line' },
}

local wk = require('which-key')

wk.register(mappings, { prefix = '<leader>' })
wk.register(g, { prefix = 'g' })
wk.register(comments, { prefix = ',' })
