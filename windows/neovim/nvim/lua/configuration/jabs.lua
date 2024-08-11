require("jabs").setup({
    position = { "left", "top" },
    sort_mru = false,
    split_filename = true,
    symbols = {
        current = "->",
        split = "S",
        alternate = "A",
        hidden = "H",
        locked = "L",
        ro = "R",
        edited = "*",
        terminal = ">_",
        default_file = "D",
        terminal_symbol = ">_",
    },
    keymap = {
        h_split = "h",
        v_split = "v",
        preview = "p",
    },
})
