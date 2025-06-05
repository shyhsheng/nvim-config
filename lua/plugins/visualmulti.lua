-- visualmulti.lua
return {
    "mg979/vim-visual-multi",
    branch = "master", -- 使用 master 分支
    init = function()
        -- 啟用預設按鍵綁定
        vim.g.VM_default_mappings = 1

        -- 自訂按鍵對應
        vim.g.VM_maps = {
            ["Find Under"]         = "<C-n>",     -- 選取當前單字
            ["Find Subword Under"] = "<C-n>",
            ["Select All"]         = "\\A",       -- 選取全部相同單字
            ["Add Cursor Down"]    = "<C-Down>",  -- 新增下一個光標
            ["Add Cursor Up"]      = "<C-Up>",    -- 新增上一個光標
        }
    end
}

