local ok_mason, mason = pcall(require, "mason")
if not ok_mason then
    vim.notify("Mason not found")
    return
end

local ok_masontoolinstaller, mason_tool_installer = pcall(require, "mason-tool-installer")
if not ok_masontoolinstaller then
    vim.notify("Mason tool installer not found")
    return
end

local registry = require("lsp.registry")
local mason_registry = require("mason-registry")

local function filter_installed(tbl)
    return vim.tbl_filter(function(pkg)
        return mason_registry.has_package(pkg)
    end, vim.tbl_values(tbl))
end

mason.setup({
    ui = {
        border = "rounded",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
})

mason_tool_installer.setup({
    ensure_installed = vim.tbl_extend(
        "force",
        filter_installed(registry.servers),
        filter_installed(registry.tools)
    ),
    auto_update = true,
    run_on_start = true,
})
