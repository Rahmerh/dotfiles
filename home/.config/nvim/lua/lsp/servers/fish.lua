local lspconfig = require("lspconfig")
local config = require("lsp.config")
local configs = require("lspconfig.configs")

if not configs.fish then
    configs.fish = {
        default_config = {
            cmd = { "fish-lsp", "start" },
            filetypes = { "fish" },
            root_dir = lspconfig.util.find_git_ancestor,
            single_file_support = true,
        },
    }
end

lspconfig.fish.setup({
    on_attach = config.on_attach,
    capabilities = config.capabilities,
})
