return {
    "dstein64/nvim-scrollview",
    event = { "BufEnter" },
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
        vim.opt.mouse = "a"
        vim.g.scrollview_base_size = 5
        require("scrollview").setup({
            excluded_filetypes = { "NvimTree","TelescopePrompt" },
            current_only = true,
            winblend = 0,
            --width = 50,
            base = '#',
            signs_on_startup = { "diagnostics", "search", "marks", "cursor" },
            mouse = true, -- Explicitly enable mouse support
        })
        -- Optional: Keymaps for manual control
        --vim.keymap.set("n", "<leader>ms", ":ScrollViewEnable<CR>", { desc = "Show scrollbar" })
        --vim.keymap.set("n", "<leader>mc", ":ScrollViewDisable<CR>", { desc = "Hide scrollbar" })
        --vim.keymap.set("n", "<leader>mr", ":ScrollViewRefresh<CR>", { desc = "Refresh scrollbar" })
    end,
}
