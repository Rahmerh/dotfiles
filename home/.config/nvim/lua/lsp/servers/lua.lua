local lspconfig = require("lspconfig")
local config = require("lsp.config")

lspconfig.lua_ls.setup({
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";"),
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
