local servers = {
    lua_ls = "lua-language-server",
    bashls = "bash-language-server",
    omnisharp = "omnisharp",
    fish = "fish-lsp",
    gopls = "gopls",
    rust = "rust-analyzer"
}

local extra_tools = {
    "netcoredbg",
    "bash-debug-adapter",
    "codelldb"
}

return {
    servers = servers,
    tools = extra_tools,
}
