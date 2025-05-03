return {
    "stevearc/aerial.nvim",
    opts = {},
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("aerial").setup({
            -- 自動開啟/關閉 aerial
            autojump = true,
            layout = {
                min_width = 28,
                default_direction = "right", -- 可選 left/right/float
            },
            show_guides = true,
            attach_mode = "window", -- 或 global
            filter_kind = false, -- 預設列出所有 kinds，也可只列出 Function/Class 等
        })

        -- 建議搭配 telescope 使用（可選）
        require("telescope").load_extension("aerial")
    end,
    keys = {
        { "<leader>a", "<cmd>AerialToggle<CR>", desc = "切換大綱視圖 (Aerial)" },
        { "<leader>fa", "<cmd>Telescope aerial<CR>", desc = "用 Telescope 搜尋符號" },
    },
    cmd = { "AerialToggle", "AerialOpen", "AerialClose" },
}
