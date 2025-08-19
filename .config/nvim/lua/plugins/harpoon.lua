require("harpoon").setup()

vim.keymap.set("n", "<leader>ha", function() require("harpoon.mark").add_file() end, { desc = "Add file" })
vim.keymap.set("n", "<leader>hh", function() require("harpoon.ui").toggle_quick_menu() end, { desc = "Harpoon menu" })
vim.keymap.set("n", "<leader>h[", function() require("harpoon.ui").nav_prev() end, { desc = "Previous mark" })
vim.keymap.set("n", "<leader>h]", function() require("harpoon.ui").nav_next() end, { desc = "Next mark" })
