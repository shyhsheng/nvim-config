return {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
        local jdtls = require("jdtls")
        local home = os.getenv("HOME")
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local workspace_dir = home .. "/.local/share/eclipse/" .. project_name

        local config = {
            cmd = {
                "jdtls", -- mason 安裝路徑自動加入 PATH 後可直接用
                "-data", workspace_dir,
            },
            root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        }

        jdtls.start_or_attach(config)
    end,
}

