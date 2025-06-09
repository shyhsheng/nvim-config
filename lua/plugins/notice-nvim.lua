return
{
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",   -- UI 元件基礎
        "rcarriga/nvim-notify",   -- 浮動訊息顯示
    },
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = false,        -- `false` 代表搜尋輸入顯示為浮動窗
            command_palette = true,       -- 類似 VSCode 的 Cmd Palette UI
            long_message_to_split = true, -- 訊息太長時自動送到 split
            inc_rename = false,           -- 若搭配 `inc-rename.nvim`
            lsp_doc_border = true,        -- LSP 浮窗加上邊框
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                opts = { skip = true },
            },
        },
        cmdline = {
            enabled = true, -- 啟用 cmdline UI（這是顯示你打的 `dd`, `ciw` 的部分）
            view = "cmdline_popup",  -- 就這一行讓它顯示在中間
        },
        messages = {
            enabled = true, -- 啟用 message 顯示（像是 `:w` 後的 written）
        },
        views = {
            cmdline_popup = {
                position = {
                    row = "50%",
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = "auto",
                },
                border = {
                    style = "rounded", -- 可改 "rounded" 或 "none"
                },
                win_options = {
                    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                },
            },
        },
    },
}

