local lspconfig = require("lspconfig")
local config = require("lsp.config")

lspconfig.rust_analyzer.setup({
    root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json", ".git"),
    capabilities = config.capabilities,
    on_attach = config.on_attach,
})
