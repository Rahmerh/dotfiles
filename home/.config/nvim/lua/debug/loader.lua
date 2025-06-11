local adapters_path = vim.fn.stdpath("config") .. "/lua/debug/adapters"

for _, file in ipairs(vim.fn.readdir(adapters_path)) do
    if file:sub(-4) == ".lua" then
        local module = "debug.adapters." .. file:sub(1, -5)
        local ok, err = pcall(require, module)
        if not ok then
            vim.notify("Failed to load " .. module .. ": " .. err)
        end
    end
end
