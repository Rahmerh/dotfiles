local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
	return
end
project.setup({
	active = true,
	on_config_done = nil,
	manual_mode = false,
	detection_methods = { "pattern" },
	patterns = { "pom.xml", ".git" },
	show_hidden = false,
	silent_chdir = true,
	ignore_lsp = {},
	datapath = vim.fn.stdpath("data"),
})
