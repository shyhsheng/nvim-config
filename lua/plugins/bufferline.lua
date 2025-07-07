return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    vim.opt.termguicolors = true
    local function deleteCurrentBuffer(bufnr)
        --[[找出所有可切換的非 NvimTree buffer
            local buffers = vim.tbl_filter(function(buf)
                return vim.api.nvim_buf_is_loaded(buf)
                    and vim.api.nvim_buf_get_option(buf, 'buflisted')
                    and not vim.api.nvim_buf_get_name(buf):match('NvimTree_')
            end, vim.api.nvim_list_bufs())

            -- 切換到另一個 buffer（只要不是這個）
            for _, buf in ipairs(buffers) do
                if buf ~= bufnr then
                    vim.api.nvim_set_current_buf(buf)
                    break
                end
            end

            -- 刪除原本 buffer
            vim.cmd('bdelete ' .. bufnr)--]]

        local buffers = require("bufferline.state").components
        local target_index = nil

        for i, comp in ipairs(buffers) do
            if comp.id == bufnr then
                target_index = i
                break
            end
        end

        if target_index and target_index > 1 then
            -- 切到左邊的 buffer
            local left_bufnr = buffers[target_index - 1].id
            vim.api.nvim_set_current_buf(left_bufnr)
        elseif target_index and #buffers > 1 then
            -- 沒有左邊的就試右邊
            local right_bufnr = buffers[target_index + 1].id
            if right_bufnr then
                vim.api.nvim_set_current_buf(right_bufnr)
            end
        end

        -- 最後刪除原本 buffer
        vim.cmd('bdelete ' .. bufnr)
    end
    require("bufferline").setup({
        highlights = {
            fill = {
                bg = "#1a1b26",
            },
            background = {
                fg = "#7aa2f7",
                bg = "#24283b",  -- 比 fill 深一點，區分背景
            },
            buffer_visible = {
                fg = "#7aa2f7",
                bg = "#24283b",
            },
            buffer_selected = {
                fg = "#ff9e64",
                bg = "#3b4261",
                bold = true,
                italic = false,
            },
            separator = {
                fg = "#1a1b26",
                bg = "#1a1b26",
            },
            separator_visible = {
                fg = "#1a1b26",
                bg = "#24283b",
            },
            separator_selected = {
                fg = "#3b4261",
                bg = "#3b4261",
            },
            modified_selected = {
                fg = "#f7768e",
                bg = "#3b4261",
            },
            indicator_selected = {
                fg = "#7aa2f7",
                sp = "#7aa2f7",
                underline = true,
            },
            close_button = {
                fg = "#7aa2f7",
                bg = "#24283b",
            },
            close_button_visible = {
                fg = "#7aa2f7",
                bg = "#24283b",
            },
            close_button_selected = {
                fg = "#f7768e",
                bg = "#3b4261",
            },
            offset_separator = {
                fg = "#1a1b26",  -- 關鍵設定，避免 separator 延伸進 NvimTree
                bg = "#1a1b26",
            },
        },
        options = {
            mode = "buffers",
            --separator_style = "slant",
            separator_style = {"▍", "▍"},
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
                separator = true,  -- Enable separator
                padding = 1,      -- Add space between NvimTree and bufferline
            }},
            close_command = function(bufnr)
                deleteCurrentBuffer(bufnr)
            end,
        },
    })
    -- 快捷鍵切換 buffer（可選）
    vim.keymap.set("n", "<C-Right>", "<Cmd>BufferLineCycleNext<CR>", { desc = "下一個 buffer" })
    vim.keymap.set("n", "<C-Left>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "上一個 buffer" })
    vim.keymap.set("n", "<C-S-Left>", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })
    vim.keymap.set("n", "<C-S-Right>", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })
    vim.keymap.set("n", "<leader>w", function()
      deleteCurrentBuffer(vim.api.nvim_get_current_buf())
    end , { desc = "Close current buffer" })
  end,
}
