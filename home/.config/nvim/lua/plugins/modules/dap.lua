return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            require("debug.bash")
            require("debug.dotnet")
            require("debug.rust")
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dapui = require("dapui")
            local dap = require("dap")
            local icons = require("config.icons")
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
        end
    },
    {
        "Weissle/persistent-breakpoints.nvim",
        config = function()
            local pb = require("persistent-breakpoints")
            pb.setup {
                save_dir = vim.fn.stdpath('data') .. '/nvim_checkpoints',
                load_breakpoints_event = { "BufReadPost" },
            }
        end
    },
}
