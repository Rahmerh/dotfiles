return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "lua",
                    "bash",
                    "c_sharp",
                    "fish",
                    "go",
                    "rust",
                },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                    disable = { "python" },
                },
                autopairs = {
                    enable = true,
                },
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
            })
        end,
    },
}
