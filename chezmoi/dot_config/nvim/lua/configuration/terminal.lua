local status_ok, terminal = pcall(require, "FTerm")
if not status_ok then
	return
end

terminal.setup({
	cmd = [ "fish" ],
})
