return {
    {
        "nvim-telescope/telescope.nvim",
        version = false, -- always use latest version
        dependencies = {
            "nvim-lua/plenary.nvim",           -- telescope 依賴的工具函式庫
            "nvim-telescope/telescope-fzf-native.nvim", -- 提供更快的模糊搜尋
            build = "make",
        },
        cmd = "Telescope",
        keys = {
            { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files (Ctrl+P)" },
            { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live Grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help Tags" },
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    layout_strategy = "horizontal",
                    layout_config = {
                        --preview_width = 0.6,
                        width = 0.9,
                        height = 0.9,
                    },
                    file_ignore_patterns = {
                        "node_modules/",
                        ".git/",
                        "build/",
                        "dist/",
                        "%.lock",     -- 忽略 lock 檔，如 package-lock.json、yarn.lock
                        "venv/", ".venv/",
                    },
                    sorting_strategy = "ascending",
                    winblend = 0,
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                    layout_config = {
                        preview_width = 0.6,
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })
            -- 載入 fzf 模組
            pcall(require("telescope").load_extension, "fzf")
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function ()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    }
                }
            })
            require("telescope").load_extension("ui-select")
        end
    }
}


