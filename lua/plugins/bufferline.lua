return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    vim.opt.termguicolors = true
    vim.cmd([[
        hi BufferLineBufferSelected gui=underline guifg=#66d9ef guibg=#3e3e3e
        hi BufferLineBufferVisible gui=underline guifg=#66d9ef guibg=#2e2e2e
    ]])
    require("bufferline").setup({
        --[[highlights = {
            indicator_selected = {
                fg = "#ff0000",   -- 紅色的指示器（圖示）
                sp = "#ff0000",   -- 底線的顏色
            },
            buffer_selected = {
                guifg = "#66d9ef",  -- 文字顏色
                guibg = "#3e3e3e",  -- 背景顏色
                gui = "underline",   -- 確保使用下劃線
            },
            buffer_visible = {
                gui = "underline",   -- 也給非選中的 buffer 添加下劃線
                guifg = "#c0c0c0",    -- 顯示顏色（可根據需求調整）
                guibg = "#2e2e2e",
            },
        },]]
        options = {
            mode = "buffers",
            separator_style = "slant",
            diagnostics = "nvim_lsp",
            show_buffer_close_icons = true,
            show_close_icon = true,
            always_show_bufferline = true,
            indicator = {
                style = "underline",    -- 或 "icon" / "none"
            },
            offsets = {{
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left",
            }},
        },
    })
    --[[vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", {
        underline = true,
        sp = "#ff0000",
        fg = "#ff0000",
    })]]

    -- 快捷鍵切換 buffer（可選）
    vim.keymap.set("n", "<C-Right>", "<Cmd>BufferLineCycleNext<CR>", { desc = "下一個 buffer" })
    vim.keymap.set("n", "<C-Left>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "上一個 buffer" })
    vim.keymap.set("n", "<C-S-Left>", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })
    vim.keymap.set("n", "<C-S-Right>", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })
  end,
}
