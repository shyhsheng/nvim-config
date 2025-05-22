require("config.options")
require("config.keymaps")
require("config.lazy")

-- lazy.nvim 插件系統
require("lazy").setup({
    {import = "plugins"},
    {import = "plugins.lsp"},
}, {
    change_detection = {
        enabled = true,
        notify = false,
    }
})
