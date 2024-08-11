require("hbac").setup({
    autoclose = true,
    threshold = 10,
    close_command = function(bufnr)
        vim.api.nvim_buf_delete(bufnr, {})
    end,
    close_buffers_with_windows = false,
})
