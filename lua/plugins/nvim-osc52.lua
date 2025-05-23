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

        -- 快速鍵：選取後按 <leader>c 複製到剪貼簿
        vim.keymap.set('v', '<C-c>', function()
            require('osc52').copy_visual()
        end, { desc = "Copy to clipboard (OSC52)" })
    end
}
