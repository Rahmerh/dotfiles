local lspconfig = require("lspconfig")
local config = require("lsp.config")

lspconfig.omnisharp.setup({
    cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),
    capabilities = config.capabilities,
    on_attach = config.on_attach,
})
