local status_ok, conform = pcall(require, "conform")
if not status_ok then
    vim.notify("conform not found!")
    return
end

local project_formatter_settings = vim.fn.getcwd() .. "\\formatter_settings.xml"

local f = io.open(project_formatter_settings, "r")
if f == nil then
    vim.notify("'formatter_settings.xml' not found in " .. vim.fn.getcwd() .. ", not setting up formatter.")
    return
else
    io.close(f)
end

conform.setup({
    format_after_save = {
        lsp_format = "fallback",
    },
    notify_no_formatters = true,
    formatters_by_ft = {
        lua = { "stylua" },
        java = { "intellij" },
    },
    formatters = {
        intellij = {
            command = "format.bat",
            args = { "-s", project_formatter_settings, "$FILENAME" },
            stdin = false,
        },
    },
})
