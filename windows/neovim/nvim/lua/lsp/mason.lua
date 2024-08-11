local status_ok, mason = pcall(require, "mason")
if not status_ok then
    vim.notify("Mason not found!")
    return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
    vim.notify("Mason-lspconfig not found!")
    return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    vim.notify("lspconfig not found!")
    return
end

require("mason-tool-installer").setup({
    ensure_installed = {
        -- LSP
        "jdtls",
        "lua-language-server",
        "typescript-language-server",
        "dockerfile-language-server",
        "bash-language-server",
        "lua-language-server",
        -- Formatters
        "stylua",
        -- DAP
        "java-test",
        "java-debug-adapter",
    },
    auto_update = true,
    run_on_start = true,
})

local settings = {
    ui = {
        border = "rounded",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
})

local servers = mason_lspconfig.get_installed_servers()

for _, server in ipairs(servers) do
    local opts = {
        on_attach = require("lsp.handlers").on_attach,
        capabilities = require("lsp.handlers").capabilities,
    }

    -- We don't set up jdtls, leave that to the jdtls plugin
    if server == "jdtls" then
        goto continue
    end

    lspconfig[server].setup(opts)
    ::continue::
end
