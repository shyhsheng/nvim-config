return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add          = { text = "+" },
                change       = { text = "~" },
                delete       = { text = "_" },
                topdelete    = { text = "‾" },
                changedelete = { text = "~" },
            },
            current_line_blame = true, -- 打開即時單行 blame
            current_line_blame_opts = {
                virt_text = false,       -- 不要用虛擬文字
                virt_text_pos = "eol",   -- （可忽略，因為我們用浮動窗）
                delay = 100,
                ignore_whitespace = false,
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                vim.keymap.set("n", "<leader>gb", function()
                    gs.blame_line({ full = true })
                end, { buffer = bufnr, desc = "浮動視窗顯示目前行 blame" })
            end,
        }
    },
    --[[{
        "f-person/git-blame.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- for example
            enabled = true,  -- if you want to enable the plugin
            message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
            date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
            virtual_text_column = 1,  -- virtual text start column, check Start virtual text at column section for more options
        },
    }]]
}

