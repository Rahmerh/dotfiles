local neoclip_ok, neoclip = pcall(require, "neoclip")
if not neoclip_ok then
	vim.notify("Neoclip not found.")
	return
end

neoclip.setup({
	enable_persistent_history = true,
	db_path = "/Users/bas/.local/share/nvim/databases/telescope_neoclip.sqlite3",
})
