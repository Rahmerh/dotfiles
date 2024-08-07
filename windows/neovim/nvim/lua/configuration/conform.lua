local status_ok, conform = pcall(require, "conform")
if not status_ok then
    vim.notify("conform not found!")
    return
end

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" }
    }
})
