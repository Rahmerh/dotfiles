local status_ok, surround = pcall(require, "nvim-surround")
if not status_ok then
    vim.notify("Surround not found!")
    return
end

surround.setup();
