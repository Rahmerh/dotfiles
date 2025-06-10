local servers_path = vim.fn.stdpath("config") .. "/lua/lsp/servers"

for _, file in ipairs(vim.fn.readdir(servers_path)) do
    if file:sub(-4) == ".lua" then
        local module = "lsp.servers." .. file:sub(1, -5)
        local ok, err = pcall(require, module)
        if not ok then
            vim.notify("Failed to load " .. module .. ": " .. err)
        end
    end
end
