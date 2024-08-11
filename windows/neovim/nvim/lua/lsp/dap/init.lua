local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    vim.notify("Dap not found!")
    return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
    vim.notify("Dapui not found!")
    return
end

local icons = require("core.icons")

require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})

dapui.setup({
    icons = { expanded = icons.ui.fat_arrow_open, collapsed = icons.ui.fat_arrow_closed },
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
                "watches",
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
            pause = icons.debugging.pause,
            play = icons.debugging.play,
            step_into = icons.debugging.step_into,
            step_over = icons.debugging.step_over,
            step_out = icons.debugging.step_out,
            step_back = icons.debugging.step_back,
            run_last = icons.debugging.run_last,
            terminate = icons.debugging.terminate,
        },
    },
})

vim.fn.sign_define(
    "DapBreakpoint",
    { text = icons.debugging.breakpoint, texthl = "DiagnosticSignError", linehl = "", numhl = "" }
)

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

vim.api.nvim_create_autocmd({ "BufReadPost" }, { callback = require("persistent-breakpoints.api").load_breakpoints })

require("persistent-breakpoints").setup({
    save_dir = os.getenv("USERPROFILE") .. "\\AppData\\Local\\nvim-data\\nvim_checkpoints",
    perf_record = false,
})

-- Setup all DAP adapters.
require("lsp.dap.java").setup()
