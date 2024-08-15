local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
    return
end

local icons = require("core.icons")

M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = icons.diagnostics.error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.information },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        virtual_lines = true,
        virtual_text = true,
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "if_many",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)
end

return M
