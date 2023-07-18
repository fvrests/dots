local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("user/options")
require("user/keymaps")
require("lazy").setup("plugins", {
	install = { colorscheme = { "rose-pine" } },
	change_detection = { notify = false },
})

-- advent of code keymaps
vim.keymap.set("n", "<space>b", ":!deno run --allow-read part1.ts<cr>")
-- vim.keymap.set('n', '<space>b', ':!deno run --allow-read part2.ts<cr>')
-- vim.keymap.set('n', '<space>b', ':!deno run --allow-read main.ts<cr>')
-- vim.keymap.set("n", "<space>b", ":!cargo run --bin day03<cr>")
