local cmp_status_ok, trouble = pcall(require, "trouble")
if not cmp_status_ok then
    vim.notify("Trouble not found!")
    return
end

trouble.setup({
    auto_preview = false,
    win = {
        type = "float",
        relative = "editor",
        position = { 0, -2 },
        size = { width = 0.3, height = 0.3 },
        zindex = 200,
    },
})
