-- A Neovim plugin to copy text to the system clipboard using the ANSI OSC52 sequence.
return {
    'ojroques/nvim-osc52',
    event = "VeryLazy",
    config = function()
        local is_tmux = os.getenv("TMUX") ~= nil
        require('osc52').setup {
            max_length = 0,            -- 不限制複製長度
            trim = false,              -- 不自動修剪空白
            silent = false,            -- 顯示提示
            tmux_passthrough = is_tmux -- 不要特殊處理 tmux
        }

        -- 工具函數：檢查指令是否存在
        local function has_cmd(cmd)
            return vim.fn.executable(cmd) == 1
        end

        -- 檢查系統 clipboard 是否可用
        local function has_system_clipboard()
            return vim.fn.has('clipboard') == 1
                or has_cmd('xclip')
                or has_cmd('xsel')
                or has_cmd('wl-copy')
                or has_cmd('pbcopy')
        end

        -- 智慧複製/剪下 function
        local function smart_copy_or_cut(mode)
            local action = mode or 'y'  -- 預設是複製

            if has_system_clipboard() then
                -- 系統 clipboard
                vim.cmd('normal! "' .. '+' .. action)
                -- vim.notify('[Clipboard] ' .. (action == 'y' and 'Copied' or 'Cut') .. ' using system clipboard')
            else
                -- osc52 fallback，只支援複製
                osc52.copy_visual()
                vim.notify('[Clipboard] Copied using OSC52 (fallback)')
            end

            -- 離開 Visual 模式
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
        end

        -- 快速鍵：Visual 模式下複製
        vim.keymap.set('v', '<C-c>', function() smart_copy_or_cut('y') end, { desc = "Smart Copy to Clipboard" })

        -- 你也可以額外新增剪下：
        vim.keymap.set('v', '<C-x>', function() smart_copy_or_cut('d') end, { desc = "Smart Cut to Clipboard" })
    end
}
