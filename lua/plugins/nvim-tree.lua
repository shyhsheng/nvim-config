-- plugins/nvim-tree.lua
return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup({
            sort_by = "case_sensitive",
            view = {
                width = 30,
                side = "left",
                preserve_window_proportions = true,
            },
            renderer = {
                group_empty = true,
                highlight_git = true,
                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                },
            },
            filters = {
                dotfiles = false,
                custom = { "^.git$" },
            },
            git = {
                enable = true,
                ignore = false,
            },
            actions = {
                open_file = {
                    quit_on_open = false,
                },
            },
            update_focused_file = {
                enable = true,
                update_cwd = true,
                update_root = true,
            },
            respect_buf_cwd = true,
            sync_root_with_cwd = true,
        })

        -- 快捷鍵
        vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
        --vim.keymap.set("n", "<leader>f", "<cmd>NvimTreeFindFile<CR>", { desc = "Focus current file in tree" })

        -- 開啟 Neovim 時自動啟用 NvimTree（如果是目錄）
        local function open_nvim_tree(data)
            local directory = vim.fn.isdirectory(data.file) == 1
            if directory then
                vim.cmd.cd(data.file)
                require("nvim-tree.api").tree.open()
            end
        end
        vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
    end,
}

