local red = "#ff0000"
local yellow = "#ffff31"
local cyan = "#a6e7ff"
local green = "#32cd32"

require("scrollbar").setup({
    show_in_active_only = true,
    hide_if_all_visible = true,
    handlers = {
        diagnostic = true,
        search = true,
        gitsigns = true
    },
    handle = {
        color = "#7e7e7e",
    },
    marks = {
        Search = {
            text = { "-", "=" },
            priority = 0,
            color = green,
            cterm = nil,
            highlight = "Search",
        },
        Error = {
            text = { "-", "=" },
            priority = 1,
            color = red,
            cterm = nil,
            highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
            text = { "-", "=" },
            priority = 2,
            color = yellow,
            cterm = nil,
            highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
            text = { "-", "=" },
            priority = 3,
            color = cyan,
            cterm = nil,
            highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
            text = { "-", "=" },
            priority = 4,
            color = cyan,
            cterm = nil,
            highlight = "DiagnosticVirtualTextHint",
        },
        Misc = {
            text = { "-", "=" },
            priority = 5,
            color = green,
            cterm = nil,
            highlight = "Normal",
        },
    },
    autocmd = {
        render = {
            "BufWinEnter",
            "TabEnter",
            "TermEnter",
            "WinEnter",
            "CmdwinLeave",
            "TextChanged",
            "VimResized",
            "WinScrolled",
        },
        clear = {
            "BufWinLeave",
            "TabLeave",
            "TermLeave",
            "WinLeave",
        },
    },
})
