local status_ok, inlay_hints = pcall(require, "lsp-inlayhints")
if not status_ok then
    vim.notify("Inlay hints was not found.")
    return
end

inlay_hints.setup()
