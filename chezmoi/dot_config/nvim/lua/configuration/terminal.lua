local status_ok, terminal = pcall(require, "FTerm")
if not status_ok then
    vim.notify("FTerm not found.")
    return
end

terminal.setup({
    cmd = os.getenv("SHELL"),
})
