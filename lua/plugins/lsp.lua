return {
    {
        "williamboman/mason.nvim",
        config = function ()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function ()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls","clangd" }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function ()
            local lspconfig = require("lspconfig")
            local on_attach = function(_, bufnr)
                local opts = { buffer = bufnr }
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
            end

            lspconfig.lua_ls.setup({ on_attach = on_attach })
            lspconfig.clangd.setup({ on_attach = on_attach })
        end
    }
}
