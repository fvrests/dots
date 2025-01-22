-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

require("user/options")
require("user/keymaps")
require("lazy").setup("plugins", { install = { colorscheme = { "rose-pine" } }, change_detection = { notify = false } })
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- colorscheme that will be used when installing plugins
	install = { colorscheme = { "rose-pine" } },
	-- if true, lazy will automatically check for plugin updates
	checker = { enabled = false },
})

-- -- advent of code keymaps
-- vim.keymap.set("n", "<space>b", ":!deno run --allow-read part1.ts<cr>")
-- vim.keymap.set('n', '<space>b', ':!deno run --allow-read part2.ts<cr>')
-- vim.keymap.set('n', '<space>b', ':!deno run --allow-read main.ts<cr>')
-- vim.keymap.set("n", "<space>b", ":!cargo run --bin day03<cr>")
