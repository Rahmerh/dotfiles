local bundles = {}

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = "/Users/bas/.local/share/nvim/jdtls/data/" .. project_name

vim.list_extend(bundles, vim.split(vim.fn.glob("/Users/bas/.config/nvim/vscode-java-test/server/*.jar"), "\n"))
vim.list_extend(
    bundles,
    vim.split(
        vim.fn.glob(
            "/Users/bas/.config/nvim/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
        ),
        "\n"
    )
)

local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        "/Users/bas/.config/coc/extensions/coc-java-data/server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
        "-configuration",
        "/Users/bas/.config/coc/extensions/coc-java-data/server/config_mac",
        "-data",
        workspace_dir,
    },
    root_dir = require("jdtls.setup").find_root({ ".git", "pom.xml" }),
    settings = {
        java = {
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
            },
        },
    },
    sources = {
        organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
        },
    },
    init_options = {
        bundles = bundles,
    },
}
require("jdtls").start_or_attach(config)
require("jdtls").setup_dap()
