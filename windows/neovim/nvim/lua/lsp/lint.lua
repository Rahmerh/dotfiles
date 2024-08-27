local status_ok, lint = pcall(require, "lint")
if not status_ok then
    vim.notify("lint not found!")
    return
end

lint.linters.checkstyle.args = {
    "-c",
    vim.fn.getcwd() .. "\\local-development\\checkstyle_configuration.xml",
}

lint.linters.pmd = {
    cmd = "pmd",
    args = {
        "--format",
        "json",
        "--rulesets",
        "local-development\\maven-pmd-plugin-rules.xml",
        "--dir",
        vim.fn.expand("%:p:h"),
        "--cache",
        "local-development\\pmd-cache",
    },
    parser = function(output, bufnr)
        local diagnosticOutput = {}

        local json = vim.json.decode(output)

        for k, file in pairs(json.files) do
            for violationKey, violation in pairs(file.violations) do
                if file.filename == vim.fn.expand("%:p") then
                    table.insert(diagnosticOutput, {
                        bufnr = bufnr,
                        lnum = violation.beginline - 1,
                        end_lnum = violation.endline - 1,
                        col = violation.begincolumn - 1,
                        end_col = violation.endcolumn,
                        severity = violation.priority,
                        source = "pmd",
                        message = violation.description,
                        code = violation.ruleset .. "/" .. violation.rule,
                    })
                end
            end
        end

        return diagnosticOutput
    end,
    ignore_exitcode = true,
    stdin = true,
    append_fname = true,
}

lint.linters_by_ft = {
    java = { "checkstyle", "pmd" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
