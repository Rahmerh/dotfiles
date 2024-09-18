local status_ok, conform = pcall(require, "conform")
if not status_ok then
    vim.notify("conform not found!")
    return
end

conform.setup({
    formatters = {
        google_java_format = {
            command = "google-java-format",
            args = { "-a", "-" },
        },
    },
    notify_no_formatters = true,
    formatters_by_ft = {
        lua = { "stylua" },
        java = { "google_java_format" },
        json = { "fixjson" },
        typescript = { "prettierd" },
    },
})
