return {
    {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.opt.termguicolors = true
        vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
    'bluz71/vim-nightfly-colors',
    lazy = false;
    priority = 900,
        config = function()
        -- 設定顏色主題
        vim.cmd('colorscheme nightfly')
        end
    },
}
