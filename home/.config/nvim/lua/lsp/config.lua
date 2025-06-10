local ok_lspconfig, lspconfig = pcall(require, "lspconfig")
if not ok_lspconfig then
    vim.notify("lspconfig not found")
    return
end

local server_map = require("lsp.install").servers

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local configs = require("lspconfig.configs")
if not configs.fish then
    configs.fish = {
        default_config = {
            cmd = { "fish-lsp" },
            filetypes = { "fish" },
            root_dir = require("lspconfig.util").find_git_ancestor,
            single_file_support = true,
        },
    }
end

local function on_attach(_, _) end

for server, _ in pairs(server_map) do
    lspconfig[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end
