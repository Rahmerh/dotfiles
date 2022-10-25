require("lsp.autopairs")
require("lsp.mason")
require("lsp.cmp")
require("lsp.dap")
require("lsp.formatter")

require("lsp.handlers").setup();

require('renamer').setup {
    title = 'Rename',
    padding = {
        top = 0,
        left = 0,
        bottom = 0,
        right = 0,
    },
    min_width = 15,
    max_width = 45,
    border = true,
    border_chars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    show_refs = true,
    with_qf_list = true,
    with_popup = true,
}
