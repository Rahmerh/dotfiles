local servers = {
    lua_ls = "lua-language-server",
    bashls = "bash-language-server",
    omnisharp = "omnisharp",
    fish = "fish-lsp",
    gopls = "gopls",
}

local extra_tools = {
    "netcoredbg",
    "bash-debug-adapter"
}

return {
    servers = servers,
    tools = extra_tools,
}
