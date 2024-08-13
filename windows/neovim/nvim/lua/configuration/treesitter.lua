local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup({
    highlight = {
        enable = true,
        disable = { "css" },
    },
    autopairs = {
        enable = true,
    },
    rainbow = {
        enable = false,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    indent = { enable = true, disable = { "python", "css" } },
})
