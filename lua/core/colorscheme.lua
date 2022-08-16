local colorscheme = "nord"

vim.cmd([[
    set termguicolors
    let g:edge_style = 'neon'
    let g:edge_better_performance = 1
]])

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
