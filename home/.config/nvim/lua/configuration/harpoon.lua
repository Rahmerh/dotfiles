require("harpoon").setup({
    save_on_toggle = true,
    save_on_change = true,
    enter_on_sendcmd = false,
    tmux_autoclose_windows = false,
    excluded_filetypes = { "harpoon" },
    mark_branch = true,
    menu = {
        width = 200,
    }
})
