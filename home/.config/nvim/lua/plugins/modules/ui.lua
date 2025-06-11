return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "petertriho/nvim-scrollbar",
        },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = '│' },
                    change       = { text = '│' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signcolumn = true,
                numhl = false,
                linehl = false,
                word_diff = false,
                watch_gitdir = {
                    interval = 1000,
                    follow_files = true,
                },
                attach_to_untracked = true,
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol',
                    delay = 0,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil,
                max_file_length = 40000,
                preview_config = {
                    border = 'single',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1,
                },
            })

            require("scrollbar.handlers.gitsigns").setup()
        end,
    },
    {
        "petertriho/nvim-scrollbar",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local red = "#ff0000"
            local yellow = "#ffff31"
            local cyan = "#a6e7ff"
            local green = "#32cd32"

            require("scrollbar").setup({
                show_in_active_only = true,
                hide_if_all_visible = true,
                handlers = {
                    diagnostic = true,
                    search = false,
                    gitsigns = true,
                },
                handle = {
                    color = "#7e7e7e",
                },
                marks = {
                    Search = {
                        text = { "-", "=" },
                        priority = 0,
                        color = green,
                        highlight = "Search",
                    },
                    Error = {
                        text = { "-", "=" },
                        priority = 1,
                        color = red,
                        highlight = "DiagnosticVirtualTextError",
                    },
                    Warn = {
                        text = { "-", "=" },
                        priority = 2,
                        color = yellow,
                        highlight = "DiagnosticVirtualTextWarn",
                    },
                    Info = {
                        text = { "-", "=" },
                        priority = 3,
                        color = cyan,
                        highlight = "DiagnosticVirtualTextInfo",
                    },
                    Hint = {
                        text = { "-", "=" },
                        priority = 4,
                        color = cyan,
                        highlight = "DiagnosticVirtualTextHint",
                    },
                    Misc = {
                        text = { "-", "=" },
                        priority = 5,
                        color = green,
                        highlight = "Normal",
                    },
                    GitAdd = {
                        text = "┆",
                        priority = 7,
                        color = green,
                        highlight = "GitSignsAdd",
                    },
                    GitChange = {
                        text = "┆",
                        priority = 7,
                        color = yellow,
                        highlight = "GitSignsChange",
                    },
                    GitDelete = {
                        text = "▁",
                        priority = 7,
                        color = red,
                        highlight = "GitSignsDelete",
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
        end,
    },
    "johann2357/nvim-smartbufs",
    {
        "kdheepak/tabline.nvim",
        event = "VeryLazy",
        config = function()
            require("tabline").setup({
                enable = true,
                options = {
                    section_separators = { "|", "|" },
                    component_separators = { "|", "|" },
                    max_bufferline_percent = 66,
                    show_tabs_always = true,
                    show_devicons = false,
                    show_bufnr = false,
                    show_filename_only = true,
                    modified_icon = "[+] ",
                    modified_italic = true,
                    show_tabs_only = false,
                },
            })

            vim.cmd([[
                set guioptions-=e
                set sessionoptions+=tabpages,globals
            ]])
        end,
    },
    {
        "Djancyp/outline",
        config = function()
            require("outline").setup()
        end,
    },
    {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
        config = function()
            require("harpoon").setup({
                save_on_toggle = true,
                save_on_change = true,
                enter_on_sendcmd = false,
                tmux_autoclose_windows = false,
                excluded_filetypes = { "harpoon" },
                mark_branch = true,
                menu = {
                    width = 200,
                },
            })
        end,
    },
    {
        "Mofiqul/vscode.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("vscode").setup({
                italic_comments = true,
                disable_nvimtree_bg = true,
                transparent = true
            })
            vim.cmd("colorscheme vscode")
        end,
    },
}
