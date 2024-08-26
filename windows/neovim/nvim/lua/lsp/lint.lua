local status_ok, lint = pcall(require, "lint")
if not status_ok then
    vim.notify("lint not found!")
    return
end

local nullls_status_ok, null_ls = pcall(require, "null-ls")
if not nullls_status_ok then
    vim.notify("Null-ls not found!")
    return
end

lint.linters.checkstyle.ignore_exitcode = false
lint.linters.checkstyle.args = {
    "-c",
    vim.fn.getcwd() .. "\\local-development\\checkstyle_configuration.xml",
}

lint.linters_by_ft = {
    java = { "checkstyle" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

require("mason-nvim-lint").setup()

null_ls.setup({
    debug = true,
    sources = {
        null_ls.builtins.diagnostics.pmd.with({
            command = { "pmd" },
            extra_args = {
                "--rulesets",
                "local-development\\maven-pmd-plugin-rules.xml",
                "--dir",
                vim.fn.expand("%:p:h"),
                "--cache",
                "local-development\\pmd-cache\\",
            },
        }),
    },
})
