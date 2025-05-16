local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
    return
end

local icons = require("core.icons")

require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})

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
                "scopes",
            },
            size = 60,
            position = "right",
        },
        {
            elements = {
                "console",
            },
            size = 0.25,
            position = "bottom",
        },
    },
    floating = {
        max_height = nil,
        max_width = nil,
        border = "rounded",
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil,
    },
    controls = {
        enabled = true,
        element = "breakpoints",
        icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "□",
        },
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

-- Setup all DAP adapters.
require("lsp.dap.dotnet").setup()
require("lsp.dap.java").setup()
require("lsp.dap.dart").setup()
