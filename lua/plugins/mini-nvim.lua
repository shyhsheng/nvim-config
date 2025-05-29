return {
    {
        "echasnovski/mini.nvim",
        version = "*",
        config = function()
            require("mini.map").setup({
                integrations = {
                    require("mini.map").gen_integration.builtin_search(),
                    require("mini.map").gen_integration.gitsigns(),
                    require("mini.map").gen_integration.diagnostic(),
                },
                symbols = {
                    encode = require("mini.map").gen_encode_symbols.dot("4x2"),
                },
                window = {
                    side = "right",
                    width = 10,
                    winblend = 25,
                },
            })
            require("mini.cursorword").setup()
            vim.cmd([[ highlight MiniCursorword guibg=#3b4261 gui=underline ]])

            -- 啟用 surround，快速新增/修改/刪除包圍符號
            require("mini.surround").setup()

            -- Add surrounding with sa (in visual mode or on motion).
            -- Delete surrounding with sd.
            -- Replace surrounding with sr.
            -- Find surrounding with sf or sF (move cursor right or left).
            -- Highlight surrounding with sh.
            -- Change number of neighbor lines with sn (see :h MiniSurround-algorithm).

            -- 啟用 indentscope，顯示縮排範圍的動態線條
            -- require("mini.indentscope").setup({
            --     filetypes = {
            --         "lua", "python", "rust", "typescript", "javascript", "c", "cpp", "java"
            --     },
            -- })

            -- 快捷鍵
            vim.keymap.set("n", "<leader>mm", function()
                require("mini.map").toggle()
            end, { desc = "Toggle MiniMap" })
        end,
    }

}
