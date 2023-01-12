local options = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap space as leader key
vim.keymap.set("n", "<Space>", "<Nop>", options)

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", options)
vim.keymap.set("n", "<C-h>", "<C-w>h", options)
vim.keymap.set("n", "<C-j>", "<C-w>j", options)
vim.keymap.set("n", "<C-k>", "<C-w>k", options)
vim.keymap.set("n", "<C-l>", "<C-w>l", options)

-- Merging
vim.keymap.set("n", "mp2", "<cmd>diffput 2<cr>", options)
vim.keymap.set("n", "mp3", "<cmd>diffput 3<cr>", options)

-- File explorer
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")

-- Buffers
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", options)
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", options)
vim.keymap.set("n", "Q", "<cmd>Bdelete<cr>", options)

vim.keymap.set("n", "<leader>l", "<cmd>noh<cr>", options)

vim.keymap.set("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", options)
vim.keymap.set("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", options)

vim.keymap.set("n", "<leader>o", "o<Esc>", options)
vim.keymap.set("n", "<leader>O", "O<Esc>", options)

vim.keymap.set("v", ">", ">gv", options)
vim.keymap.set("v", "<", "<gv", options)

-- Indent blocks when moving them
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", options)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", options)

-- Keep cursor in place when appending line to line above
vim.keymap.set("n", "J", "mzJ`z", options)

-- Keep view in the middle of the page when doing half page jumpsu
vim.keymap.set("n", "<C-d>", "<C-d>zz", options)
vim.keymap.set("n", "<C-u>", "<C-u>zz", options)

-- Gitsigns
vim.keymap.set("n", "gs", "<cmd>Gitsigns toggle_current_line_blame<cr>", options)

-- Hlslens
vim.keymap.set('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'nzz')<CR><Cmd>lua require('hlslens').start()<CR>]],
    options)
vim.keymap.set('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'Nzz')<CR><Cmd>lua require('hlslens').start()<CR>]],
    options)
vim.keymap.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], options)
vim.keymap.set('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], options)
vim.keymap.set('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], options)
vim.keymap.set('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], options)
--
-- Keep copy buffer while pasting over items
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to system clipboard
vim.keymap.set("v", "<leader>y", [["+y]], options)
vim.keymap.set("n", "<leader>y", [["+y]], options)
vim.keymap.set("n", "<leader>Y", [["+Y]], options)

-- Terminal
local fterm = require("FTerm")

local lazygit = fterm:new({
    ft = "fterm_lazygit",
    cmd = "lazygit",
})

vim.keymap.set("n", "<C-/>", function()
    lazygit:toggle()
end)

vim.keymap.set("n", "<C-\\>", "<cmd>lua require('FTerm').toggle()<cr>", options)
vim.keymap.set("t", "<C-\\>", "<C-\\><C-N><cmd>lua require('FTerm').toggle()<cr>", options)

-- Fuzzy search
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>", options)
vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>", options)

-- LSP
vim.keymap.set("n", "<C-.>", "<cmd>CodeActionMenu<CR>", options)
vim.keymap.set("n", "<leader>i", "<cmd>lua require('jdtls').organize_imports()<CR>", options)
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", options)
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", options)
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", options)
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", options)
vim.keymap.set("n", "R", "<cmd>lua require('renamer').rename()<cr>", options)

-- Debugging
vim.keymap.set("n", "<F5>", "<cmd>DapContinue<cr>", options)
vim.keymap.set("n", "<F10>", "<cmd>DapStepOver<cr>", options)
vim.keymap.set("n", "<F11>", "<cmd>DapStepInto<cr>", options)
vim.keymap.set("n", "<F23>", "<cmd>DapStepOut<cr>", options) -- S-F11
vim.keymap.set("n", "<F17>", "<cmd>DapTerminate<cr>", options) -- S-F5
vim.keymap.set("n", "<C-b>", "<cmd>PBToggleBreakpoint<cr>", options)
vim.keymap.set("n", "td", "<cmd>lua require'jdtls'.test_nearest_method()<cr>", options)
vim.keymap.set("n", "tc", "<cmd>lua require'jdtls'.test_class()<cr>", options)
vim.keymap.set("n",
    "<C-t>",
    "<cmd>lua require('dapui').float_element('watches', { width = 200, height = 30, enter = true })<cr>",
    options
)
