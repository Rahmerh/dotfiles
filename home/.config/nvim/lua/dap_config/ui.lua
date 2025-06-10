local ok_dap, dap = pcall(require, "dap")
if not ok_dap then
    vim.notify("nvim-dap not found", vim.log.levels.ERROR)
    return
end

local ok_dapui, dapui = pcall(require, "dapui")
if not ok_dapui then
    vim.notify("nvim-dap-ui not found", vim.log.levels.ERROR)
    return
end

local icons = require("core.icons")

dapui.setup({
    layouts = {
        {
            elements = {
                { id = "scopes",      size = 0.25 },
                { id = "breakpoints", size = 0.25 },
                { id = "stacks",      size = 0.25 },
                { id = "watches",     size = 0.25 },
            },
            size = 40,
            position = "right",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 10,
            position = "bottom",
        },
    },
    controls = {
        enabled = true,
        element = "repl",
        icons = icons.debugging.controls,
    },
})

vim.fn.sign_define("DapBreakpoint", {
    text = icons.debugging.Breakpoint,
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
