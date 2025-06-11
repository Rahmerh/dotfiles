local has_dap, _ = pcall(require, "dap")
if not has_dap then
    vim.notify("nvim-dap not found", vim.log.levels.WARN)
    return
end

require("debug.loader")
require("debug.breakpoints")
require("debug.ui")
