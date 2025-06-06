local ok_mason, mason = pcall(require, "mason")
if not ok_mason then return end

local ok_lspconfig, lspconfig = pcall(require, "lspconfig")
if not ok_lspconfig then return end

local servers = {
    "lua_ls",
    "bashls",
    "omnisharp",
    "dockerls",
    "jdtls",
    "lemminx",
    "fish",
    "gopls"
}

require("mason-tool-installer").setup({
    ensure_installed = {
        -- LSPs
        "lua-language-server",
        "omnisharp",
        "jdtls",
        "lemminx",
        "gopls",
        -- DAP
        "netcoredbg",
        "java-debug-adapter",
        "java-test",
    },
    auto_update = true,
    run_on_start = true,
})

-- Setup mason UI (optional)
mason.setup({
    ui = {
        border = "rounded",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
})


local on_attach = require("lsp.handlers").on_attach
local capabilities = require("lsp.handlers").capabilities

-- Fish LSP isn't built-in, register it manually
local configs = require("lspconfig.configs")
configs.fish = {
    default_config = {
        cmd = { "fish-lsp" },
        filetypes = { "fish" },
        root_dir = require("lspconfig.util").find_git_ancestor,
        single_file_support = true,
    },
}

for _, server in ipairs(servers) do
    if server == "jdtls" then
        goto continue
    end

    lspconfig[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })

    ::continue::
end
