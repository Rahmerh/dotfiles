local status_ok, conform = pcall(require, "conform")
if not status_ok then
    vim.notify("conform not found!")
    return
end

local project_formatter_settings = vim.fn.getcwd() .. "\\local-development\\formatter_settings.xml"

local project_pom = vim.fn.getcwd() .. "\\pom.xml"
local pom_file = io.open(project_pom, "r")
if pom_file ~= nil then
    io.close(pom_file)

    -- Directory is maven project, check for formatter settings.
    local f = io.open(project_formatter_settings, "r")
    if f == nil then
        vim.notify("'formatter_settings.xml' not found in " .. vim.fn.getcwd() .. ", not setting up formatter.")
        return
    else
        io.close(f)
    end
end

conform.setup({
    format_after_save = {
        lsp_format = "fallback",
    },
    notify_no_formatters = true,
    formatters_by_ft = {
        lua = { "stylua" },
        java = { "intellij" },
        json = { "fixjson" },
        typescript = { "prettierd" },
    },
    formatters = {
        intellij = {
            -- This is assuming the intellij bin folder is added to your $PATH
            command = "format.bat",
            args = { "-s", project_formatter_settings, "$FILENAME" },
            stdin = false,
        },
    },
})
