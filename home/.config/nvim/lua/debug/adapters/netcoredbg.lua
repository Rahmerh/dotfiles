local dap = require("dap")
local Path = require("plenary.path")

local function get_project_metadata_path()
    local root = vim.fn.getcwd()
    local dir = Path:new(root):joinpath(".nvim")

    if not dir:exists() then
        dir:mkdir({ parents = true })
    end

    return dir:joinpath("dap-meta.json"):absolute()
end

local function read_metadata()
    local file_path = get_project_metadata_path()
    local file = io.open(file_path, "r")
    if not file then return nil end
    local ok, result = pcall(vim.fn.json_decode, file:read("*a"))
    file:close()
    return (ok and type(result) == "table") and result or nil
end

local function write_metadata(data)
    local file_path = get_project_metadata_path()
    local file = io.open(file_path, "w")
    if not file then return end
    file:write(vim.fn.json_encode(data))
    file:close()
end

dap.adapters.coreclr = {
    type = "executable",
    command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
    args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "Launch .NET",
        request = "launch",
        program = function()
            local meta = read_metadata()

            if not meta or not meta.csproj then
                local csproj = vim.fn.input("Select the csproj you want to automatically start while debugging: ", "", "file")
                if csproj == "" then return nil end
                meta = { csproj = csproj }
                write_metadata(meta)
            end

            local project_name = vim.fn.fnamemodify(meta.csproj, ":t:r")
            local build_dir = Path:new(meta.csproj):parent():joinpath("bin/Debug")
            local dll_candidates = vim.fn.glob(build_dir:absolute() .. "/*/" .. project_name .. ".dll", true, true)

            if #dll_candidates == 0 then
                vim.notify("No dlls found, did you build the project?", vim.log.levels.ERROR)
                return nil
            end

            -- Most recent dll, in case you've built for other versions before.
            table.sort(dll_candidates, function(a, b)
                return vim.loop.fs_stat(a).mtime.sec > vim.loop.fs_stat(b).mtime.sec
            end)

            return dll_candidates[1]
        end
    },
}
