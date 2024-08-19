local bundles = {}

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = os.getenv("USERPROFILE") .. "\\AppData\\Local\\nvim-data\\projects\\" .. project_name

vim.list_extend(
    bundles,
    vim.split(
        vim.fn.glob(
            os.getenv("USERPROFILE")
                .. "\\AppData\\Local\\nvim-data\\mason\\packages\\java-test\\extension\\server\\*.jar"
        ),
        "\n"
    )
)

vim.list_extend(
    bundles,
    vim.split(
        vim.fn.glob(
            os.getenv("USERPROFILE")
                .. "\\AppData\\Local\\nvim-data\\mason\\packages\\java-debug-adapter\\extension\\server\\com.microsoft.java.debug.plugin-*.jar"
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
        "-javaagent:" .. os.getenv("USERPROFILE") .. "\\AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\lombok.jar",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        os.getenv("USERPROFILE")
            .. "\\AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\plugins\\org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar",
        "-configuration",
        os.getenv("USERPROFILE") .. "\\AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\config_win",
        "-data",
        workspace_dir,
    },
    root_dir = require("jdtls.setup").find_root({ ".git" }),
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
                updateSnapshots = true,
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
                enabled = false,
            },
            saveActions = {
                organizeImports = false,
            },
            autobuild = {
                enabled = true,
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            contentProvider = { preferred = "fernflower" },
            signatureHelp = { enabled = true },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
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

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.java" },
    callback = function()
        vim.lsp.codelens.refresh()
    end,
})
require("jdtls").start_or_attach(config)

config["on_attach"] = function(client, bufnr)
    require("jdtls").setup_dap({ hotcodereplace = "auto" })
end

require("jdtls.ui").pick_one_async = function(items, prompt, label_fn, cb)
    local opts = {}
    pickers
        .new(opts, {
            prompt_title = prompt,
            finder = finders.new_table({
                results = items,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = label_fn(entry),
                        ordinal = label_fn(entry),
                    }
                end,
            }),
            sorter = sorters.get_generic_fuzzy_sorter(),
            attach_mappings = function(prompt_bufnr)
                actions.goto_file_selection_edit:replace(function()
                    local selection = actions.get_selected_entry(prompt_bufnr)
                    actions.close(prompt_bufnr)

                    cb(selection.value)
                end)

                return true
            end,
        })
        :find()
end

vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
)
vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
)
vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
