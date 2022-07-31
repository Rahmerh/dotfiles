require('nvim-lsp-setup').setup({
    -- Default mappings
    -- gD = 'lua vim.lsp.buf.declaration()',
    -- gd = 'lua vim.lsp.buf.definition()',
    -- gt = 'lua vim.lsp.buf.type_definition()',
    -- gi = 'lua vim.lsp.buf.implementation()',
    -- gr = 'lua vim.lsp.buf.references()',
    -- K = 'lua vim.lsp.buf.hover()',
    -- ['<C-k>'] = 'lua vim.lsp.buf.signature_help()',
    -- ['<space>rn'] = 'lua vim.lsp.buf.rename()',
    -- ['<space>ca'] = 'lua vim.lsp.buf.code_action()',
    -- ['<space>f'] = 'lua vim.lsp.buf.formatting()',
    -- ['<space>e'] = 'lua vim.diagnostic.open_float()',
    -- ['[d'] = 'lua vim.diagnostic.goto_prev()',
    -- [']d'] = 'lua vim.diagnostic.goto_next()',
    default_mappings = true,
    -- Custom mappings, will overwrite the default mappings for the same key
    -- Example mappings for telescope pickers:
    -- gd = 'lua require"telescope.builtin".lsp_definitions()',
    -- gi = 'lua require"telescope.builtin".lsp_implementations()',
    -- gr = 'lua require"telescope.builtin".lsp_references()',
    mappings = {},
    -- Global on_attach
    on_attach = function(client, bufnr)
        require('nvim-lsp-setup.utils').format_on_save(client)
        if client.name == "jdt.ls" then
            vim.lsp.codelens.refresh()
            require("jdtls").setup_dap { hotcodereplace = "auto" }
            require("jdtls.dap").setup_dap_main_class_configs()
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.textDocument.completion.completionItem.snippetSupport = false
        end
    end,
    -- Global capabilities
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    -- Configuration of LSP servers 
    servers = {
        jdtls = {},
    },
})
