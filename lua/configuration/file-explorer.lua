local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
	return
end

local tree_cb = nvim_tree_config.nvim_tree_callback
local icons = require("core.icons")

nvim_tree.setup({
	auto_reload_on_write = true,
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = {
		"startify",
		"dashboard",
		"alpha",
	},
	renderer = {
		icons = {
			glyphs = {
				default = icons.ui.List,
				symlink = icons.ui.Symlink,
				git = {
					unstaged = icons.git.FileChanged,
					staged = icons.git.FileStaged,
					unmerged = icons.git.FileUnmerged,
					renamed = icons.git.FileRenamed,
					deleted = icons.git.Remove,
					untracked = icons.git.FileUntracked,
					ignored = icons.git.FileIgnored,
				},
				folder = {
					default = icons.documents.Folder,
					open = icons.documents.OpenFolder,
					empty = icons.documents.EmptyFolder,
					empty_open = icons.documents.EmptyOpenFolder,
					symlink = icons.documents.FolderSymlink,
				},
			},
		},
	},
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = true,
	diagnostics = {
		enable = true,
		icons = {
			hint = icons.diagnostics.Hint,
			info = icons.diagnostics.Information,
			warning = icons.diagnostics.Warning,
			error = icons.diagnostics.Error,
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	view = {
		adaptive_size = true,
		width = 30,
		height = 30,
		hide_root_folder = false,
		side = "left",
		mappings = {
			custom_only = false,
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
				{ key = "h", cb = tree_cb("close_node") },
				{ key = "v", cb = tree_cb("vsplit") },
			},
		},
		number = false,
		relativenumber = false,
	},
})
