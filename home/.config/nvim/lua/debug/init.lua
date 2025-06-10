local has_dap, _ = pcall(require, "dap")
if not has_dap then
    vim.notify("nvim-dap not found", vim.log.levels.WARN)
    return
end

require("debug.breakpoints")
require("debug.ui")

local registry = require("lsp.registry")

for _, tool in ipairs(registry.tools) do
    local ok, err = pcall(require, "debug.adapters." .. tool)
    if not ok then
        vim.notify("Failed to load dap." .. tool .. ": " .. err, vim.log.levels.ERROR)
    end
end
