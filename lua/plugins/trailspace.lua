return {
    "echasnovski/mini.trailspace",
    config = function()
        require("mini.trailspace").setup({
            only_in_normal_buffers = true,
        })
        vim.keymap.set("n", "<leader>tw", function()
            require('mini.trailspace').trim()
            print("Trailing whitespace removed!")
        end, { desc = "Trim trailing whitespace" })

        vim.keymap.set("n", "<leader>tl", function()
            require('mini.trailspace').trim_last_lines()
            print("Trailing empty lines removed!")
        end, { desc = "Trim trailing empty lines" })
    end,
}
