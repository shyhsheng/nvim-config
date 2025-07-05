-- lazy.nvim 完整範例：Telescope + filetype 選單 grep

local telescope_config = {}

local picker_opts = {
    layout_strategy = "horizontal",
    layout_config = {
        width = 0.4,
        height = 0.8,
        prompt_position = "top",
    },
}

-- local function build_ext_to_type(callback)
--     local Job = require("plenary.job")
--     local ext_to_type = {}
--
--     Job:new({
--         command = "rg",
--         args = { "--type-list" },
--         on_exit = function(j)
--             local result = j:result()
--             for _, line in ipairs(result) do
--                 local type_name, patterns = line:match("^(.-):%s*(.+)")
--                 if type_name and patterns then
--                     for ext in patterns:gmatch("%*%.([%w_]+)") do
--                         ext_to_type[ext] = type_name
--                     end
--                 end
--             end
--             if callback then
--                 callback(ext_to_type)
--             end
--         end,
--     }):start()
-- end

function telescope_config.grep_by_filetype()
    local builtin = require("telescope.builtin")
    local entry_display = require("telescope.pickers.entry_display")
    local themes = require("telescope.themes")
    local Job = require("plenary.job")

    local filetypes = {
        { type = "Multiple", desc = "Multiple File Type" },
        { type = "All", desc = "All Type" },
        -- { type = "Current", desc = "Current File Type" },
        { type = "C/C++", desc = "C/C++" },
        { type = "lua", desc = "Lua" },
        { type = "java", desc = "Java" },
        { type = "py", desc = "Python" },
        { type = "cpp", desc = "C++" },
        { type = "c", desc = "C" },
        { type = "go", desc = "Golang" },
        { type = "rust", desc = "Rust" },
        { type = "sh", desc = "Shell script" },
        { type = "bash", desc = "Bash script" },
        { type = "html", desc = "HTML" },
        { type = "css", desc = "CSS" },
        { type = "javascript", desc = "JavaScript" },
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

    vim.schedule(function()
        require("telescope.pickers").new(picker_opts, {
            prompt_title = "Select File Type",
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

                    local function run_live_grep(type_args, title)
                        builtin.live_grep({ additional_args = type_args, prompt_title = "Grep: " .. title })
                    end

                    if type_name == "sh" then
                        args = { "--type-add=sh:*.sh", "--type=sh" }
                        run_live_grep(args, type_name)
                    elseif type_name == "C/C++" then
                        args = { "--type=c", "--type=cpp" }
                        run_live_grep(args, type_name)
                    elseif type_name == "Current" then
                        -- build_ext_to_type(functton(map)
                        --     local ext = vim.fn.expand("%:e")
                        --     if ext ~= "" then
                        --         args = { "--type=" .. map[ext] }
                        --         run_live_grep(args, "Current: " .. map[ext])
                        --     else
                        --         vim.notify("No File Type，無法判斷 filetype", vim.log.levels.WARN)
                        --     end
                        -- end)
                    elseif type_name == "Multiple" then
                        Job:new({
                            command = "rg",
                            args = { "--type-list" },
                            on_exit = function(j)
                                vim.schedule(function()
                                    local results = {}
                                    for _, line in ipairs(j:result()) do
                                        local ft = line:match("^(.-):")
                                        if ft then
                                            table.insert(results, { type = ft, desc = "ripgrep 支援的檔案類型" })
                                        end
                                    end

                                    local selected_types = {}

                                    local make_sub_entry = function(entry) return { value = entry.type, display = function(e)
                                                local mark = selected_types[e.value] and "✔" or " "
                                                return string.format("[%s] %s", mark, e.value)
                                            end,
                                            ordinal = entry.type,
                                        }
                                    end

                                    require("telescope.pickers").new(picker_opts, {
                                        prompt_title = "Choose ripgrep file type (Select: <Tab>, Confirm: <CR>)",
                                        finder = require("telescope.finders").new_table({ results = results, entry_maker = make_sub_entry }),
                                        sorter = require("telescope.config").values.generic_sorter({}),
                                        previewer = false,
                                        attach_mappings = function(bufnr2, map2)
                                            local action_state2 = require("telescope.actions.state")
                                            local actions2 = require("telescope.actions")
                                            local function reflash_picker()
                                                local picker = action_state2.get_current_picker(bufnr2)
                                                local entry = action_state2.get_selected_entry()
                                                if entry then
                                                    selected_types[entry.value] = not selected_types[entry.value]
                                                    local selected_value = entry.value
                                                    local new_finder = require("telescope.finders").new_table{
                                                        results      = results,
                                                        entry_maker  = make_sub_entry,
                                                    }
                                                    picker:refresh(
                                                        new_finder,
                                                        { reset_prompt = false, reset_selection = false }
                                                    )
                                                    vim.schedule(function()
                                                        vim.defer_fn(function()
                                                            for i, v in ipairs(results) do
                                                                if v.type == selected_value then
                                                                    picker:set_selection(i-1)
                                                                    break
                                                                end
                                                            end
                                                        end, 20)          -- 20 ms 幾乎已足夠，太短可調大V
                                                    end)
                                                end
                                            end
                                            map2("n", "<Tab>", reflash_picker)
                                            map2("i", "<Tab>", reflash_picker)

                                            local function confirm()
                                                local args = {}
                                                for type_name, selected in pairs(selected_types) do
                                                    if selected then
                                                        table.insert(args, "--type=" .. type_name)
                                                    end
                                                end
                                                actions2.close(bufnr2)
                                                run_live_grep(args, table.concat(args, " "))
                                            end

                                            map2("i", "<CR>", confirm)
                                            map2("n", "<CR>", confirm)

                                            return true
                                        end,
                                    }):find()
                                end)
                            end,
                        }):start()
                    elseif type_name == "ALL" then
                        run_live_grep({}, type_name)
                    else
                        args = { "--type=" .. type_name }
                        run_live_grep(args, type_name)
                    end
                end

                map("i", "<CR>", select)
                map("n", "<CR>", select)
                return true
            end,
        }):find()
    end)
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

