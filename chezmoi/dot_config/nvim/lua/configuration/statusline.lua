local staline_ok, staline = pcall(require, "staline")
if not staline_ok then
    vim.notify("Staline was not found.")
    return
end


local status = require 'nvim-spotify'.status

status:start()

local icons = require("core.icons")
staline.setup({

    sections = {
        left  = {
            ' ', 'mode', ' ',
            'file_name', ' ',
            'branch', ' ',
        },
        mid   = { status.listen },
        right = {
            'lsp_name',
            'line_column', ' ',
        }
    },
    defaults = {
        fg = "#7a86bd",
        line_column = " [%l/%L] :%c  ",
        true_colors = true,
        branch_symbol = icons.git.Branch .. " "
    },
    mode_colors = {
        i = "#d4be98",
        n = "#84a598",
        c = "#8fbf7f",
        v = "#fc802d",
    }
})
