local status_ok, comment = pcall(require, "Comment")
if not status_ok then
    vim.notify("Comment not found!")
    return
end

comment.setup({
    toggler = {
        line = "<leader>k",
    },
    opleader = {
        line = "<leader>u",
    },
})
