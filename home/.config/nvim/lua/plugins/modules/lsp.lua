return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("lsp.servers.bash")
            require("lsp.servers.fish")
            require("lsp.servers.lua")
            require("lsp.servers.rust")
        end
    },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonLog" },
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
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        event = { "BufReadPre", "BufNewFile" },
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
    {
        "lewis6991/hover.nvim",
        keys = {
            { "K", function() require("hover").hover() end, desc = "Hover docs" },
        },
        config = function()
            require("hover").setup {
                init = function()
                    require("hover.providers.lsp")
                end,
                preview_opts = { border = "none" },
                title = true,
            }
        end,
    }
}
