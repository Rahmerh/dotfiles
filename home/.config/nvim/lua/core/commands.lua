local floatterm = require("ui.floatterm")

vim.api.nvim_create_user_command("W", 'execute "SudaWrite"', {})
vim.api.nvim_create_user_command("E", 'execute "SudaRead"', {})

vim.api.nvim_create_user_command("FloatTerm", function(opts)
    floatterm.toggle(opts.args ~= "" and opts.args or nil)
end, { nargs = "?" })
