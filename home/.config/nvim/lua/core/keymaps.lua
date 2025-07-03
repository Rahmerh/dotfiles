local options = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General
vim.keymap.set("n", "<Space>", "<Nop>", options)
vim.keymap.set("n", "<leader>R", function()
    local file = vim.fn.expand("%")
    vim.cmd("luafile " .. file)
    vim.notify("Reloaded '" .. file .. "'")
end, { desc = "Source current file" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", options)
vim.keymap.set("n", "<C-h>", "<C-w>h", options)
vim.keymap.set("n", "<C-j>", "<C-w>j", options)
vim.keymap.set("n", "<C-k>", "<C-w>k", options)
vim.keymap.set("n", "<C-l>", "<C-w>l", options)

-- Buffers
vim.keymap.set("n", "L", "<cmd>bnext<cr>", options)
vim.keymap.set("n", "H", "<cmd>bprev<cr>", options)
vim.keymap.set("n", "Q", "<cmd>bd<CR>", options)

vim.keymap.set("n", "<leader>l", "<cmd>noh<cr>", options)

vim.keymap.set("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", options)
vim.keymap.set("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", options)

vim.keymap.set("n", "<leader>o", "o<Esc>", options)
vim.keymap.set("n", "<leader>O", "O<Esc>", options)

vim.keymap.set("v", ">", ">gv", options)
vim.keymap.set("v", "<", "<gv", options)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", options)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", options)

vim.keymap.set("n", "<C-d>", "<C-d>zz", options)
vim.keymap.set("n", "<C-u>", "<C-u>zz", options)

-- Clipboard
vim.keymap.set("x", "<C-p>", [["_dP]])

vim.keymap.set("v", "<leader>y", [["+y]], options)
vim.keymap.set("n", "<leader>y", [["+y]], options)
vim.keymap.set("n", "<leader>Y", [["+Y]], options)

vim.keymap.set("v", "<leader>p", [["+p]], options)
vim.keymap.set("n", "<leader>p", [["+p]], options)
vim.keymap.set("n", "<leader>P", [["+P]], options)

-- LSP
vim.keymap.set("n", "<C-.>", "<cmd>lua vim.lsp.buf.code_action()<CR>", options)
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", options)
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", options)
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", options)
vim.keymap.set("n", "R", "<cmd>lua vim.lsp.buf.rename()<cr>", options)

-- Terminal
local floatterm = require("ui.floatterm")

vim.keymap.set({ "n", "t" }, "<leader>tt", function()
    floatterm.toggle()
end, options)

vim.keymap.set({ "n", "t" }, "<leader>te", function()
    floatterm.toggle("yazi")
end, options)

vim.keymap.set({ "n", "t" }, "<leader>tg", function()
    floatterm.toggle("lazygit")
end, options)

-- Dev
vim.keymap.set("n", "<leader>b", function()
    require("workflow.builder").build()
end, options)
