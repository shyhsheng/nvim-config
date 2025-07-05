local telescope_config = {}

local picker_opts = {
    layout_strategy = "horizontal",
    layout_config = {
        width = 0.4,
        height = 0.6,
        prompt_position = "top",
    },
}

function telescope_config.grep_by_filetype()
    local builtin = require("telescope.builtin")
    local entry_display = require("telescope.pickers.entry_display")
    -- local themes = require("telescope.themes")
    -- themes.get_dropdown({ width = 0.5, height = 0.4 })

    local filetypes = {
        { type = "custom", desc = "自訂 filetype" },
        { type = "ALL", desc = "All Type" },
        { type = "CA", desc = "C/C++" },
        { type = "lua", desc = "Lua" },
        { type = "java", desc = "Java" },
        { type = "python", desc = "Python" },
        { type = "cpp", desc = "C++" },
        { type = "c", desc = "C" },
        { type = "go", desc = "Golang" },
        { type = "rust", desc = "Rust" },
        { type = "sh", desc = "Shell script" },
        { type = "bash", desc = "Bash script" },
        { type = "html", desc = "HTML" },
        { type = "css", desc = "CSS" },
        { type = "javascript", desc = "JavaScript" },
        { type = "typescript", desc = "TypeScript" },
        { type = "markdown", desc = "Markdown" },
        { type = "json", desc = "JSON" },
        { type = "yaml", desc = "YAML" },
    }

    local displayer = entry_display.create({ separator = "  ", items = { { width = 15 }, { remaining = true } } })

    local function make_entry(entry)
        return {
            value = entry,
            display = function(e) return displayer({ e.value.type, e.value.desc }) end,
            ordinal = entry.type .. " " .. entry.desc,
        }
    end

    require("telescope.pickers").new(picker_opts, {
        prompt_title = "Select Grep File Type",
        finder = require("telescope.finders").new_table({ results = filetypes, entry_maker = make_entry }),
        sorter = require("telescope.config").values.generic_sorter({}),
        previewer = false,
        attach_mappings = function(prompt_bufnr, map)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")

            local function select()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if not selection then return end

                local type_name = selection.value.type
                local args = {}

                if type_name == "sh" then
                    args = { "--type-add=sh:*.sh", "--type=sh" }
                elseif type_name == "lua_cpp" then
                    args = { "--type=lua", "--type=cpp" }
                elseif type_name == "custom" then
                    vim.ui.input({ prompt = "輸入自訂 filetype (可用空白分隔多個) > " }, function(user_input)
                        if not user_input or user_input == "" then return end
                        args = {}
                        for ft in user_input:gmatch("%S+") do
                            table.insert(args, "--type=" .. ft)
                        end
                        builtin.live_grep({ additional_args = args, prompt_title = "Grep: " .. user_input })
                    end)
                    return
                elseif type_name == "ALL" then
                    args = {}
                else
                    args = { "--type=" .. type_name }
                end

                builtin.live_grep({ additional_args = args, prompt_title = "Grep: " .. type_name })
            end

            map("i", "<CR>", select)
            map("n", "<CR>", select)
            return true
        end,
    }):find()
end

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
            { "<leader>fm", "<cmd>Telescope marks<cr>",  desc = "Search marks" },
            { "<leader>ft", function() telescope_config.grep_by_filetype() end, desc = "Live Grep by Filetype" },
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

