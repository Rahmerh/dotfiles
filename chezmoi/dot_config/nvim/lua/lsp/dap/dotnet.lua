local M = {}

vim.g.use_simple = function()
    if vim.g["simple_sign_code"] then
        return true
    else
        return false
    end
end

vim.g.gsign = function(normal, simple)
    if vim.g.use_simple() then
        return simple
    else
        return normal
    end
end

vim.g.dotnet_build_project = function()
    local default_path = vim.fn.getcwd() .. "/"
    if vim.g["dotnet_last_proj_path"] ~= nil then
        default_path = vim.g["dotnet_last_proj_path"]
    end
    local path = vim.fn.input("Path to your *proj file", default_path, "file")
    vim.g["dotnet_last_proj_path"] = path
    local cmd = "dotnet build -c Debug " .. path .. " > /dev/null"
    print("")
    print("Cmd to execute: " .. cmd)
    local f = os.execute(cmd)
    if f == 0 then
        print("\nBuild: " .. vim.g.gsign("✔️ ", "OK"))
    else
        print("\nBuild: " .. vim.g.gsign("❌", "ERR") .. "(code: " .. f .. ")")
    end
end

vim.g.dotnet_get_dll_path = function()
    local request = function()
        return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
    end

    if vim.g["dotnet_last_dll_path"] == nil then
        vim.g["dotnet_last_dll_path"] = request()
    else
        if vim.fn.confirm("Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"], "&yes\n&no", 2)
            == 1
        then
            vim.g["dotnet_last_dll_path"] = request()
        end
    end

    return vim.g["dotnet_last_dll_path"]
end

function M.setup()
    local dap_status_ok, dap = pcall(require, "dap")
    if not dap_status_ok then
        vim.notify("Dap not found!")
        return
    end

    local config = {
        {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            program = function()
                if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
                    vim.g.dotnet_build_project()
                end
                return vim.g.dotnet_get_dll_path()
            end,
        },
    }

    dap.adapters.coreclr = {
        type = "executable",
        command = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/netcoredbg/netcoredbg",
        args = { "--interpreter=vscode", "--hot-reload", "--log=file" },
    }

    dap.configurations.cs = config
    dap.configurations.fsharp = config
end

return M
