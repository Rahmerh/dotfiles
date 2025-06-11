local dap = require("dap")
local mason_registry = require("mason-registry")

local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path()
local adapter_path = extension_path .. "/extension/adapter/codelldb"
local liblldb_path = extension_path .. "/extension/lldb/lib/liblldb.so"

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = adapter_path,
        args = { "--liblldb", liblldb_path, "--port", "${port}" },
        detached = true,
    },
}

dap.configurations.rust = {
    {
        name = "Launch executable",
        type = "codelldb",
        request = "launch",
        program = function()
            local cwd = vim.fn.getcwd()
            local output = cwd .. "/target/debug/"
            local bin = vim.fn.input("Binary name (in target/debug): ", "", "file")
            return output .. bin
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
    },
}
