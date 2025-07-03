vim.api.nvim_create_user_command("W", 'execute "SudaWrite"', {})
vim.api.nvim_create_user_command("E", 'execute "SudaRead"', {})
