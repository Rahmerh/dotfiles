local M = {}

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

function M.setup()
    dap.adapters.dart = {
        type = "executable",
        command = "node",
        args = { "~/.config/nvim/dart-code/out/dist/debug.js", "flutter" },
    }

    dap.configurations.dart = {
        {
            type = "dart",
            request = "launch",
            name = "Launch flutter",
            dartSdkPath = os.getenv("HOME") .. "/flutter/bin/cache/dart-sdk/",
            flutterSdkPath = os.getenv("HOME") .. "/flutter",
            program = "${workspaceFolder}/lib/main.dart",
            cwd = "${workspaceFolder}",
        },
    }
end

return M
