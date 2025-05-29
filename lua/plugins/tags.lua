return {
    -- 自動產生 Ctags/Gtags/Cscope tag 檔案，專為大型專案如 AOSP 設計
    {
        "ludovicchabant/vim-gutentags",
        lazy = false,
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local cache_dir = vim.fn.expand("~/.cache/tags")

            -- 建立 tags cache 目錄（避免報錯）
            if vim.fn.isdirectory(cache_dir) == 0 then
                vim.fn.mkdir(cache_dir, "p")
            end
            --vim.g.gutentags_modules = { "ctags", "gtags-cscope", "cscope" }  -- 同時支援 Ctags、GNU Global、Cscope
            vim.g.gutentags_modules = { "ctags" } -- only add ctags works now, doesn't know why add others won't work.
            vim.g.gutentags_project_root = {
                ".git", "Makefile", "BUILD", "WORKSPACE", ".projectroot"
            }
            --vim.g.gutentags_ctags_tagfile = ".tags"
            --vim.g.gutentags_add_default_project_roots = false
            vim.g.gutentags_generate_on_empty_buffer = true
            vim.g.gutentags_cache_dir = cache_dir
            vim.g.gutentags_generate_on_write = true
            vim.g.gutentags_generate_on_missing = true
            vim.g.gutentags_generate_on_new = true
            --vim.g.gutentags_trace = 1
            vim.g.gutentags_ctags_extra_args = {
                "--fields=+lniazS",
                "--extra=+q",
                "--c-kinds=+px",
                "--c++-kinds=+px",
                "--java-kinds=+p",
                "--languages=C,C++,Java",
                "--exclude=.repo",
                "--exclude=out",
                "--exclude=.git",
                "--exclude=*.pb.cc",
                "--exclude=*.pb.h",
                "--exclude=*.xml"
            }
            -- vim.g.gutentags_ctags_extra_args_table = {
            --     lua = { "--language-force=Lua" },
            --     c = { "--c-kinds=+px" },
            --     cpp = { "--c++-kinds=+px" },
            -- }
            -- cscope 設定
            vim.g.gutentags_cscope_enabled = 1
            vim.g.gutentags_cscope_auto = 1
            vim.g.gutentags_cscope_db_file = "cscope.out"
        end,
    },

    -- GNU Global 支援 (Gtags)
    -- seems doesn't work now...
    {
        "skywind3000/gutentags_plus",
        lazy = false,
        dependencies = {
            "ludovicchabant/vim-gutentags",
            "junegunn/fzf",
            "junegunn/fzf.vim",
        },
        config = function()
            vim.g.gutentags_plus_nomap = 1
            vim.g.gutentags_plus_switch = 1
            vim.g.gutentags_plus_use_fzf = 1
        end,
    },

    -- 樹狀結構檢視 tags（簡單易用）
    {
        "preservim/tagbar",
        cmd = "TagbarToggle",
        keys = {
            { "<F8>", "<cmd>TagbarToggle<CR>", desc = "Toggle Tagbar" },
        },
        config = function()
            vim.g.tagbar_width = 30
            vim.g.tagbar_autofocus = 1
        end,
    },

    -- 更強大的符號視覺瀏覽器，支援 LSP / ctags / gtags
    {
        "liuchengxu/vista.vim",
        cmd = "Vista",
        config = function()
            vim.g.vista_default_executive = "ctags"
            vim.g.vista_executive_for = {
                c = 'ctags',
                cpp = 'ctags',
                java = 'ctags',
                go = 'ctags',
            }
            vim.g.vista_ctags_cmd = {
                c = 'ctags --fields=+n --extras=+q -f -',
                cpp = 'ctags --fields=+n --extras=+q -f -',
                java = 'ctags --fields=+n --extras=+q -f -',
                go = 'ctags --fields=+n --extras=+q -f -',
            }
        end,
    },

    -- 支援 treesitter / LSP 的範圍 outline
    {
        "tiagovla/scope.nvim",
        config = function()
            require("scope").setup()
        end,
    },
}

