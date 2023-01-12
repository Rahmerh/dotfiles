local m = require("mapx").setup({ global = true })

--Remap space as leader key
m.nnoremap("<Space>", "<Nop>", "silent")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
m.nnoremap("<C-h>", "<C-w>h", "silent")
m.nnoremap("<C-h>", "<C-w>h", "silent")
m.nnoremap("<C-j>", "<C-w>j", "silent")
m.nnoremap("<C-k>", "<C-w>k", "silent")
m.nnoremap("<C-l>", "<C-w>l", "silent")

-- Merging
m.nnoremap("mp2", "<cmd>diffput 2<cr>", "silent")
m.nnoremap("mp3", "<cmd>diffput 3<cr>", "silent")

-- File explorer
m.nnoremap("<leader>e", "<cmd>NvimTreeToggle<cr>", "silent")

-- Buffers
m.nnoremap("<S-l>", "<cmd>bnext<cr>", "silent")
m.nnoremap("<S-h>", "<cmd>bprevious<cr>", "silent")
m.nnoremap("Q", "<cmd>Bdelete<cr>", "silent")

m.nnoremap("<leader>l", "<cmd>noh<cr>", "silent")

m.inoremap("<C-j>", "<esc><cmd>m .+1<cr>==gi", "silent")
m.inoremap("<C-k>", "<esc><cmd>m .-2<cr>==gi", "silent")

m.nnoremap("<leader>o", "o<Esc>", "silent")
m.nnoremap("<leader>O", "O<Esc>", "silent")

m.vnoremap(">", ">gv", "silent")
m.vnoremap("<", "<gv", "silent")

-- Indent blocks when moving them
m.vnoremap("J", ":m '>+1<CR>gv=gv", "silent")
m.vnoremap("K", ":m '<-2<CR>gv=gv", "silent")

-- Keep cursor in place when appending line to line above
m.nnoremap("J", "mzJ`z", "silent")

-- Keep view in the middle of the page when doing half page jumpsu
m.nnoremap("<C-d>", "<C-d>zz", "silent")
m.nnoremap("<C-u>", "<C-u>zz", "silent")

-- Keep view in the middle of the page when jumping to next item
m.nnoremap("n", "nzzzv", "silent")
m.nnoremap("N", "Nzzzv", "silent")

-- Keep copy buffer while pasting over items
m.xnoremap("<leader>p", [["_dP]])

-- Yank to system clipboard
m.vnoremap("<leader>y", [["+y]], "silent")
m.nnoremap("<leader>y", [["+y]], "silent")
m.nnoremap("<leader>Y", [["+Y]], "silent")

-- Terminal
local fterm = require("FTerm")

local lazygit = fterm:new({
    ft = "fterm_lazygit",
    cmd = "lazygit",
})

m.nnoremap("<C-/>", function()
    lazygit:toggle()
end)

m.nnoremap("<C-\\>", "<cmd>lua require('FTerm').toggle()<cr>", "silent")
m.tnoremap("<C-\\>", "<C-\\><C-N><cmd>lua require('FTerm').toggle()<cr>", "silent")

-- Fuzzy search
m.nnoremap("<leader>f", "<cmd>Telescope find_files<cr>", "silent")
m.nnoremap("<leader>g", "<cmd>Telescope live_grep<cr>", "silent")

-- LSP
m.nnoremap("<C-.>", "<cmd>CodeActionMenu<CR>", "silent")
m.nnoremap("<leader>i", "<cmd>lua require('jdtls').organize_imports()<CR>", "silent")
m.nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<cr>", "silent")
m.nnoremap("li", "<cmd>lua vim.lsp.buf.implementation()<cr>", "silent")
m.nnoremap("lr", "<cmd>lua vim.lsp.buf.references()<cr>", "silent")
m.nnoremap("ld", "<cmd>lua vim.lsp.buf.definition()<cr>", "silent")
m.nnoremap("R", "<cmd>lua require('renamer').rename()<cr>", "silent")

-- Debugging
m.nnoremap("<F5>", "<cmd>DapContinue<cr>", "silent")
m.nnoremap("<F10>", "<cmd>DapStepOver<cr>", "silent")
m.nnoremap("<F11>", "<cmd>DapStepInto<cr>", "silent")
m.nnoremap("<F23>", "<cmd>DapStepOut<cr>", "silent") -- S-F11
m.nnoremap("<F17>", "<cmd>DapTerminate<cr>", "silent") -- S-F5
m.nnoremap("<C-b>", "<cmd>PBToggleBreakpoint<cr>", "silent")
m.nnoremap("td", "<cmd>lua require'jdtls'.test_nearest_method()<cr>", "silent")
m.nnoremap("tc", "<cmd>lua require'jdtls'.test_class()<cr>", "silent")
m.nnoremap(
    "<C-t>",
    "<cmd>lua require('dapui').float_element('watches', { width = 200, height = 30, enter = true })<cr>",
    "silent"
)
