return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate", -- 安裝或更新語法解析器
        event = { "BufReadPost", "BufNewFile" }, -- 當打開檔案時啟用
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "HiPhish/rainbow-delimiters.nvim",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                -- 支援的語言列表（也可以用 "all"）
                ensure_installed = {
                    "lua", "vim", "bash", "python", "javascript", "typescript",
                    "html", "css", "json", "markdown", "c", "cpp"
                },

                -- 自動安裝未安裝的語言
                auto_install = true,
                sync_install = false,
                highlight = {
                    enable = true,              -- 啟用語法高亮
                    additional_vim_regex_highlighting = false,
                },

                indent = {
                    enable = true,              -- 啟用語法感知縮排
                },
                textobjects = {
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]c"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[c"] = "@class.outer",
                        },
                    },
                    -- in viual mode
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                },
            })
            -- rainbow-delimiters 設定
            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = require('rainbow-delimiters').strategy.global,
                },
                query = {
                    [''] = 'rainbow-delimiters',
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            }
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                enable = true,
                max_lines = 3, -- 顯示最大行數，可調整
                trim_scope = "outer",
                mode = "cursor", -- 或 "topline"
            })
        end,
    },
}

