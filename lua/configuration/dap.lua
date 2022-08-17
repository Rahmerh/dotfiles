local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
    return
end

local icons = require("core.icons")

dap.configurations.java = {
    {
        type = "java",
        request = "attach",
        name = "Debug (Attach) - Remote",
        hostName = "127.0.0.1",
        port = 5005,
    },
}

dapui.setup({
    icons = { expanded = icons.ui.FatArrowOpen, collapsed = icons.ui.FatArrowClosed },
    mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    expand_lines = vim.fn.has("nvim-0.7"),
    layouts = {
        {
            elements = {
                "breakpoints",
                "watches",
                "scopes"
            },
            size = 40,
            position = "right",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 0.25,
            position = "bottom",
        },
    },
    floating = {
        max_height = nil,
        max_width = nil,
        border = "single",
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil,
    },
})

vim.fn.sign_define(
    "DapBreakpoint",
    { text = icons.debugging.Breakpoint, texthl = "DiagnosticSignError", linehl = "", numhl = "" }
)

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
end

vim.api.nvim_create_autocmd({ "BufReadPost" }, { callback = require("persistent-breakpoints.api").load_breakpoints })

require("persistent-breakpoints").setup({
    save_dir = vim.fn.stdpath("data") .. "/nvim_checkpoints",
    perf_record = false,
})
