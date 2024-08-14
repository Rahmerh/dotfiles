local cmp_status_ok, trouble = pcall(require, "trouble")
if not cmp_status_ok then
    vim.notify("Trouble not found!")
    return
end

trouble.setup({
    win = {
        type = split,
        position = right,
    },
})
