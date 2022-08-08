local status_ok, jabs = pcall(require, "jabs")
if not status_ok then
	return
end

jabs.setup({
	position = "corner", -- center, corner. Default corner
	width = 80, -- default 50
	height = 20, -- default 10
})
