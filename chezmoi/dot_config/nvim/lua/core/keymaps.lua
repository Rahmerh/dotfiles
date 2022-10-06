local m = require("mapx").setup({ global = true, whichkey = true })

--Remap space as leader key
m.nnoremap("", "<Space>", "<Nop>", "silent")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
m.nnoremap("<C-h>", "<C-w>h", "silent")
m.nnoremap("<C-h>", "<C-w>h", "silent")
m.nnoremap("<C-j>", "<C-w>j", "silent")
m.nnoremap("<C-k>", "<C-w>k", "silent")
m.nnoremap("<C-l>", "<C-w>l", "silent")

-- Cheat sheet
m.nnoremap("<C-c>", "<cmd>Cheatsheet<cr>", "silent")

-- Hop
m.nnoremap("<C-o>", "<cmd>HopWord<cr>", "silent")

-- File explorer
m.nnoremap("<leader>e", "<cmd>Telescope file_browser path=%:p:h<cr>", "silent")

-- Resize with arrows
m.nnoremap("<C-Up>", ":resize +2<CR>", "silent")
m.nnoremap("<C-Down>", ":resize -2<CR>", "silent")
m.nnoremap("<C-Left>", ":vertical resize -2<CR>", "silent")

m.nnoremap("<C-Right>", ":vertical resize +2<CR>", "silent")

-- Buffers
m.nnoremap("<S-l>", "<cmd>CybuNext<cr>", "silent")
m.nnoremap("<S-h>", "<cmd>CybuPrev<cr>", "silent")
m.nnoremap("<Tab-l>", "<cmd>CybuLastUsedNext<cr>", "silent")
m.nnoremap("<Tab-h>", "<cmd>CybuLastUsedPrev<cr>", "silent")
m.nnoremap("Q", "<cmd>Bdelete<cr>", "silent")
m.nnoremap("<C-q>", "<cmd>Bdelete!<cr>", "silent")
m.nnoremap("n", "<cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<cr>", "silent")
m.nnoremap("N", "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>", "silent")
m.nnoremap("<Leader>l", "<cmd>noh<cr>", "silent")
m.nnoremap("<leader>t", "<cmd>lua require('memento').toggle()<cr>", "silent")

-- Git
m.nnoremap("<C-d>", "<cmd>DiffviewFileHistory<cr>", "silent")
m.nnoremap("D", "<cmd>DiffviewClose<cr>", "silent")
m.nnoremap("<C-/>", "<cmd>LazyGit<cr>", "silent")

-- Terminal
m.nnoremap("<C-\\>", "<cmd>lua require('FTerm').toggle()<cr>", "silent")
m.tnoremap("<C-\\>", "<C-\\><C-N><cmd>lua require('FTerm').toggle()<cr>", "silent")

-- Fuzzy search
m.nnoremap("<leader>f", "<cmd>Telescope find_files<cr>", "silent")
m.nnoremap("<leader>g", "<cmd>Telescope live_grep<cr>", "silent")

-- LSP
m.nnoremap("<C-.>", "<cmd>lua vim.lsp.buf.code_action()<CR>", "silent")
m.nnoremap("<leader>o", "<cmd>lua require('jdtls').organize_imports()<CR>", "silent")
m.nnoremap("RR", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "silent")
m.nnoremap("K", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "silent")
m.nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", "silent")
m.nnoremap("gf", "<cmd>lua vim.lsp.buf.references()<cr>", "silent")

-- Debugging
m.nnoremap("<F5>", "<cmd>DapContinue<cr>", "silent")
m.nnoremap("<F10>", "<cmd>DapStepOver<cr>", "silent")
m.nnoremap("<F11>", "<cmd>DapStepInto<cr>", "silent")
m.nnoremap("<F23>", "<cmd>DapStepOut<cr>", "silent") -- S-F11
m.nnoremap("<F17>", "<cmd>DapTerminate<cr>", "silent") -- S-F5
m.nnoremap("<C-b>", "<cmd>PBToggleBreakpoint<cr>", "silent")
m.nnoremap("<F2>", "<cmd>PBClearAllBreakpoints<cr>", "silent")
m.nnoremap("tn", "<cmd>lua require'neotest'.run.run()<cr>", "silent")
m.nnoremap("tc", "<cmd>lua require'neotest'.run.run(vim.fn.expand('%'))<cr>", "silent")
m.nnoremap("tl", "<cmd>lua require'neotest'.output.open({ enter = true })<cr>", "silent")
m.nnoremap("td", "<cmd>lua require'jdtls'.test_nearest_method()<cr>", "silent")
m.nnoremap(
	"<C-t>",
	"<cmd>lua require('dapui').float_element('watches', { width = 200, height = 30, enter = true })<cr>",
	"silent"
)

-- Color picker
m.nnoremap("<C-p>", "<cmd>PickColor<cr>", "silent")

-- Base 64
m.nnoremap("<leader>5", "<cmd>Base64Decode<cr>", "silent")
m.vnoremap("<leader>5", "<cmd>Base64Decode<cr>", "silent")
m.nnoremap("<leader>6", "<cmd>Base64Encode<cr>", "silent")
m.vnoremap("<leader>6", "<cmd>Base64Encode<cr>", "silent")

-- Music
m.nnoremap("<leader>s", "<cmd>Spotify<cr>", "silent")
m.nnoremap("<leader>sd", "<cmd>SpotifyDevices<cr>", "silent")
m.nnoremap("<leader>sp", "<Plug>(SpotifyPause)", "silent")
m.nnoremap("<leader>sc", "<cmd>Lspsaga open_floaterm spt<cr>", "silent")
