local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
    M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
else
    M.capabilities = capabilities
end

M.on_attach = function(_, _) end

return M
