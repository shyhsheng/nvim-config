return {
--     "neovim/nvim-lspconfig",
--     ft = { "c", "cpp", "h", "hpp" },
--     config = function()
--         local lspconfig = require("lspconfig")
--         lspconfig.clangd.setup({
--             on_attach = function(client, bufnr)
--                 client.server_capabilities.diagnosticProvider = false
--                 vim.diagnostic.disable(bufnr)
--                 local opts = { noremap=true, silent=true, buffer=bufnr }
--                 local keymap = vim.keymap.set
--                 keymap("n", "gd", vim.lsp.buf.definition, opts)
--                 keymap("n", "gr", vim.lsp.buf.references, opts)
--                 keymap("n", "gi", vim.lsp.buf.implementation, opts)
--                 keymap("n", "K", vim.lsp.buf.hover, opts)
--                 keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
--             end,
--             handlers = {
--                 ["textDocument/publishDiagnostics"] = function() end,
--             },
--             cmd = { "clangd-18", "--background-index", "--header-insertion=never", "--completion-style=detailed" },
--         })
--     end,
}

