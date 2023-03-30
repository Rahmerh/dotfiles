vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "neo-tree" then
			require("bufferline.api").set_offset(42, "")
		end
	end,
})

vim.api.nvim_create_autocmd("BufWinLeave", {
	pattern = "*",
	callback = function()
		if vim.fn.expand("<afile>"):match("neo-tree") then
			require("bufferline.api").set_offset(0)
		end
	end,
})

require("bufferline").setup({
	animation = true,
	auto_hide = true,
	tabpages = true,
	closable = false,
	clickable = true,
	exclude_ft = { "javascript", "neo-tree" },
	exclude_name = { "package.json" },
	icons = "both",
	icon_custom_colors = false,
	icon_separator_active = "▎",
	icon_separator_inactive = "▎",
	icon_close_tab = "",
	icon_close_tab_modified = "●",
	icon_pinned = "",
	insert_at_end = false,
	insert_at_start = false,
	maximum_padding = 1,
	maximum_length = 30,
	semantic_letters = true,
	letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
	no_name_title = nil,
})
