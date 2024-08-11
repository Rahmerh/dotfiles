local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
    vim.notify("Indent blankline not found!")
    return
end

local highlight = {
    "CursorColumn",
    "Whitespace",
}

ibl.setup({
    indent = { highlight = highlight, char = "" },
    whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
})
