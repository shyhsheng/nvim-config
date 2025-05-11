return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 700,
        config = function()
            vim.opt.termguicolors = true
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
        'bluz71/vim-nightfly-colors',
        lazy = false;
        priority = 1200,
        config = function()
            -- 設定顏色主題
            vim.cmd('colorscheme nightfly')
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 800, -- 確保它是最先載入的主題
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    treesitter = true,
                    notify = true,
                    mini = true,
                    -- 你可以依喜好增加其他 plugin 的整合
                },
            })
            -- 設定顏色主題
            vim.cmd.colorscheme "catppuccin"
        end
    },
}
