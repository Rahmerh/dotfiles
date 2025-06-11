return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lsp.servers.dotnet")
            require("lsp.servers.bash")
            require("lsp.servers.fish")
            require("lsp.servers.lua")
            require("lsp.servers.rust")
        end
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            },
            log_level = vim.log.levels.INFO,
            max_concurrent_installers = 4,
        }
    },
    "williamboman/mason-lspconfig.nvim",
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            local mason_tool_installer = require("mason-tool-installer")
            local registry = require("lsp.registry")
            local mason_registry = require("mason-registry")

            local function filter_installed(tbl)
                return vim.tbl_filter(function(pkg)
                    return mason_registry.has_package(pkg)
                end, vim.tbl_values(tbl))
            end

            mason_tool_installer.setup({
                ensure_installed = vim.tbl_extend(
                    "force",
                    filter_installed(registry.servers),
                    filter_installed(registry.tools)
                ),
                auto_update = true,
                run_on_start = true,
            })
        end
    },
    { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
    "rafamadriz/friendly-snippets",
    "folke/neodev.nvim",
    {
        "rmagatti/goto-preview",
        cmd = {
            "GotoPreviewDefinition",
            "GotoPreviewTypeDefinition",
            "GotoPreviewImplementation",
            "GotoPreviewReferences",
            "GotoPreviewClose",
        },
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("goto-preview").setup({
                width = 120,
                height = 15,
                border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
                default_mappings = false,
                debug = false,
                opacity = nil,
                resizing_mappings = false,
                post_open_hook = nil,
                references = {
                    telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
                },
                focus_on_open = true,
                dismiss_on_move = false,
                force_close = true,
                bufhidden = "wipe",
                stack_floating_preview_windows = true,
                preview_window_title = { enable = true, position = "left" },
            })
        end,
    },
    {
        "amrbashir/nvim-docs-view",
        cmd = "DocsViewToggle",
        config = function()
            require("docs-view").setup {
                position = "bottom",
                width = 30,
            }
        end,
    },
}
