local options = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap space as leader key
vim.keymap.set("n", "<Space>", "<Nop>", options)

-- Reload config
vim.keymap.set("n", "<leader><leader>", "<cmd>source $MYVIMRC<cr>", options)

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", options)
vim.keymap.set("n", "<C-h>", "<C-w>h", options)
vim.keymap.set("n", "<C-j>", "<C-w>j", options)
vim.keymap.set("n", "<C-k>", "<C-w>k", options)
vim.keymap.set("n", "<C-l>", "<C-w>l", options)

-- Buffers
vim.keymap.set("n", "<leader>b", "<cmd>BSOpen<cr>", options)

vim.keymap.set("n", "<S-l>", "<cmd>TablineBufferNext<cr>", options)
vim.keymap.set("n", "<S-h>", "<cmd>TablineBufferPrevious<cr>", options)

vim.keymap.set("n", "<leader>l", "<cmd>noh<cr>", options)

vim.keymap.set("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", options)
vim.keymap.set("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", options)

vim.keymap.set("n", "<leader>o", "o<Esc>", options)
vim.keymap.set("n", "<leader>O", "O<Esc>", options)

vim.keymap.set("v", ">", ">gv", options)
vim.keymap.set("v", "<", "<gv", options)

vim.keymap.set("n", "<leader>1", "<cmd>lua require('nvim-smartbufs').goto_buffer(1)<cr>", options)
vim.keymap.set("n", "<leader>2", "<cmd>lua require('nvim-smartbufs').goto_buffer(2)<cr>", options)
vim.keymap.set("n", "<leader>3", "<cmd>lua require('nvim-smartbufs').goto_buffer(3)<cr>", options)
vim.keymap.set("n", "<leader>4", "<cmd>lua require('nvim-smartbufs').goto_buffer(4)<cr>", options)
vim.keymap.set("n", "<leader>5", "<cmd>lua require('nvim-smartbufs').goto_buffer(5)<cr>", options)
vim.keymap.set("n", "<leader>6", "<cmd>lua require('nvim-smartbufs').goto_buffer(6)<cr>", options)
vim.keymap.set("n", "<leader>7", "<cmd>lua require('nvim-smartbufs').goto_buffer(7)<cr>", options)
vim.keymap.set("n", "<leader>8", "<cmd>lua require('nvim-smartbufs').goto_buffer(8)<cr>", options)
vim.keymap.set("n", "<leader>9", "<cmd>lua require('nvim-smartbufs').goto_buffer(9)<cr>", options)

vim.keymap.set("n", "<S-q>", "<cmd>lua require('nvim-smartbufs').close_current_buffer()<cr>", options)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", options)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", options)

vim.keymap.set("n", "<C-d>", "<C-d>zz", options)
vim.keymap.set("n", "<C-u>", "<C-u>zz", options)

-- Copy & pasting

vim.keymap.set("x", "<C-p>", [["_dP]])

vim.keymap.set("v", "<leader>y", [["+y]], options)
vim.keymap.set("n", "<leader>y", [["+y]], options)
vim.keymap.set("n", "<leader>Y", [["+Y]], options)

vim.keymap.set("v", "<leader>p", [["+p]], options)
vim.keymap.set("n", "<leader>p", [["+p]], options)
vim.keymap.set("n", "<leader>P", [["+P]], options)

-- Harpoon
vim.keymap.set("n", "<leader>h", "<cmd>lua require('harpoon.mark').add_file()<cr>", options)
vim.keymap.set("n", "<C-n>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", options)

-- Gitsigns
vim.keymap.set("n", "gs", "<cmd>Gitsigns toggle_current_line_blame<cr>", options)

-- Terminal
vim.keymap.set("n", "<C-t>", "<cmd>FloatermNew --name=Powershell pwsh<cr>", options)
vim.keymap.set("n", "<C-\\>", "<cmd>FloatermToggle Powershell<cr>", options)
vim.keymap.set("t", "<C-\\>", "<C-h><C-n><cmd>FloatermHide Powershell<cr>", options)

vim.keymap.set("n", "<C-g>", "<cmd>FloatermNew lazygit<cr>", options)

-- Tree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", options)

-- Fuzzy search
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>", options)
vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>", options)
