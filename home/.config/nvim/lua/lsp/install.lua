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

-- LSP name → Mason package name
local server_map = {
    lua_ls = "lua-language-server",
    bashls = "bash-language-server",
    omnisharp = "omnisharp",
    fish = "fish-lsp",
    gopls = "gopls",
}

local extra_tools = {
    "netcoredbg",
}

-- Filter out fish-lsp for Mason install
local installable_servers = {}
for name, pkg in pairs(server_map) do
    if name ~= "fish" then
        table.insert(installable_servers, pkg)
    end
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
    ensure_installed = vim.tbl_extend("force", installable_servers, extra_tools),
    auto_update = true,
    run_on_start = true,
})
