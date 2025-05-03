return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- 安裝或更新語法解析器
    event = { "BufReadPost", "BufNewFile" }, -- 當打開檔案時啟用
    config = function()
    require("nvim-treesitter.configs").setup({
        -- 支援的語言列表（也可以用 "all"）
        ensure_installed = {
            "lua", "vim", "bash", "python", "javascript", "typescript",
            "html", "css", "json", "markdown", "c", "cpp"
        },

        -- 自動安裝未安裝的語言
        auto_install = true,
        sync_install = false,
        highlight = {
            enable = true,              -- 啟用語法高亮
            additional_vim_regex_highlighting = false,
        },

        indent = {
            enable = true,              -- 啟用語法感知縮排
        },
    })
  end,
}

