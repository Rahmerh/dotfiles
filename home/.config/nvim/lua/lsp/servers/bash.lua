local lspconfig = require("lspconfig")
local config = require("lsp.config")

lspconfig.bashls.setup({
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    filetypes = { "sh", "bash" },
})
