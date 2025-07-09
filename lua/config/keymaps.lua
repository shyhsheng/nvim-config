vim.g.mapleader = " "

vim.keymap.set("n", "<C-s>", ":w!<CR>", { desc = "Save file" })    -- Normal 模式
vim.keymap.set("i", "<C-s>", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>:w!<CR>", true, false, true), "n", false)
end, { desc = "Save and stay in Normal mode" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent to the right consecutive"}) -- Increase indent
vim.keymap.set("v", ">", ">gv", { desc = "Indent to the left consecutive"}) --Decrease indent

vim.keymap.set("n", "vv", 'ggVG', { desc = "Select All"})
