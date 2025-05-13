return {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup({
            toggler = {
                line = "<Leader>c",   -- Normal 模式，註解目前行
            },
            opleader = {
                line = "<Leader>c",   -- Visual 模式用 gc 選取區塊
            },
        })
    end,
    lazy = false,  -- 如果你希望立即生效可以設 false
}
