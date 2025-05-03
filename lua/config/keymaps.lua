vim.g.mapleader = " "

vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })    -- Normal 模式
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" }) -- Insert 模式
