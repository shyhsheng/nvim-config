require("config.options")
require("config.keymaps")
require("config.lazy")

-- lazy.nvim 插件系統
require("lazy").setup("plugins", {
    change_detection = {
        enabled = true,
        notify = false,
    }
})
