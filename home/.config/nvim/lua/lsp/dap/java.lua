local M = {}

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

function M.setup()
    dap.configurations.java = {
        {
            type = "java",
            request = "attach",
            name = "Debug (Attach) - Remote",
            hostName = "127.0.0.1",
            port = 5005,
        },
    }
end

return M
