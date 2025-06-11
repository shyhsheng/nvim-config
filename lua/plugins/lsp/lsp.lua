return {
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- Mason 與 lspconfig 的橋接（新版 repo）
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "pyright", "jdtls", "bashls" },
                automatic_installation = false,
                automatic_enable = false,
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lspconfig = require("lspconfig")

            -- 快捷鍵設定 (只會在 buffer attach 時啟用)
            local on_attach = function(client, bufnr)
                local ft = vim.bo[bufnr].filetype

                -- 如果底下相關語言，關閉診斷
                -- local android_related = { "java", "kotlin", "c", "cpp", "h", "hpp", "xml" }
                -- if vim.tbl_contains(android_related, ft) then
                --     client.server_capabilities.diagnosticProvider = false
                --     vim.diagnostic.disable(bufnr)
                -- end

                -- 快捷鍵設定
                local opts = { noremap = true, silent = true, buffer = bufnr }
                local keymap = vim.keymap.set
                keymap("n", "gd", vim.lsp.buf.definition, opts)
                keymap("n", "gD", vim.lsp.buf.declaration, opts)
                keymap("n", "gi", vim.lsp.buf.implementation, opts)
                keymap("n", "gr", vim.lsp.buf.references, opts)
                keymap("n", "K", vim.lsp.buf.hover, opts)
                keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
                keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                keymap("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, opts)
            end

            -- LSP 設定表
            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                        },
                    },
                    handlers = {
                        ["textDocument/publishDiagnostics"] = function() end,
                    },
                },
                pyright = {
                    handlers = {
                        ["textDocument/publishDiagnostics"] = function() end,
                    },
                },
                bashls = {
                    handlers = {
                        ["textDocument/publishDiagnostics"] = function() end,
                    },
                },
                -- jdtls = {}, -- Java LSP (Android 開發可考慮啟用)
                clangd = {
                    cmd = {
                        "clangd-18",
                        "--background-index",
                        "--header-insertion=never",
                        "--completion-style=detailed",
                    },
                    handlers = {
                        ["textDocument/publishDiagnostics"] = function() end,
                    },
                },
            }

            -- 初始化各 LSP
            for name, config in pairs(servers) do
                config.on_attach = on_attach
                config.flags = { debounce_text_changes = 150 }
                lspconfig[name].setup(config)
            end
        end,
    },
}
