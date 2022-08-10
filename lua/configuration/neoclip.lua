local neoclip_ok, neoclip = pcall(require, "neoclip")
if not neoclip_ok then
	vim.notify("Neoclip not found.")
	return
end

local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
	return
end

telescope.load_extension("neoclip")

neoclip.setup({
	enable_persistent_history = true,
	db_path = "~/.local/share/nvim/databases/telescope_neoclip.sqlite3",
})
