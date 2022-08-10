local m = require("mapx").setup({ global = true, whichkey = true })

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--Remap space as leader key
m.nnoremap("", "<Space>", "<Nop>", "silent")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Markdown
m.nnoremap("<C-m>", "<cmd>CocCommand markdown-preview-enhanced.openPreview<cr>", "silent")

-- Better window navigation
m.nnoremap("<C-h>", "<C-w>h", "silent")
m.nnoremap("<C-h>", "<C-w>h", "silent")
m.nnoremap("<C-j>", "<C-w>j", "silent")
m.nnoremap("<C-k>", "<C-w>k", "silent")
m.nnoremap("<C-l>", "<C-w>l", "silent")

-- HTOP
m.nnoremap("<C-q>", ":lua _HTOP_TOGGLE()<cr>", "silent")

-- Hop
m.nnoremap("<C-g>", "<cmd>HopWord<cr>", "silent")

-- Nvimtree
m.nnoremap("<leader>e", ":NvimTreeToggle<cr>", "silent")
m.nnoremap("R", "<comd>NvimTreeRefresh<cr>", "silent")

-- Resize with arrows
m.nnoremap("<C-Up>", ":resize +2<CR>", "silent")
m.nnoremap("<C-Down>", ":resize -2<CR>", "silent")
m.nnoremap("<C-Left>", ":vertical resize -2<CR>", "silent")
m.nnoremap("<C-Right>", ":vertical resize +2<CR>", "silent")

-- Navigate buffers
m.nnoremap("<S-l>", "<cmd>CybuNext<cr>", "silent")
m.nnoremap("<S-h>", "<cmd>CybuPrev<cr>", "silent")
m.nnoremap("<Tab-l>", "<cmd>CybuLastUsedNext<cr>", "silent")
m.nnoremap("<Tab-h>", "<cmd>CybuLastUsedPrev<cr>", "silent")
m.nnoremap("Q", "<cmd>Bdelete this<cr>", "silent")
m.nnoremap("QO", "<cmd>Bdelete other<cr>", "silent")
m.nnoremap("QQ", "<cmd>Bdelete all<cr>", "silent")
m.nnoremap("<C-t>", "<cmd>JABSOpen<cr>", "silent")

-- Insert --
m.vnoremap("<", "<gv", "silent")
m.vnoremap(">", ">gv", "silent")

-- Terminal --
m.nnoremap("<C-/>", ":LazyGit<cr>", "silent")
m.nnoremap("<C-\\>", "<cmd>FloatermToggle<cr>", "silent")
m.tnoremap("<C-\\>", "<C-\\><C-N><cmd>FloatermToggle<cr>", "silent")

m.tnoremap("<C-h>", "<C-\\><C-N><C-w>h", "silent")
m.tnoremap("<C-j>", "<C-\\><C-N><C-w>j", "silent")
m.tnoremap("<C-k>", "<C-\\><C-N><C-w>k", "silent")
m.tnoremap("<C-l>", "<C-\\><C-N><C-w>l", "silent")

-- Telescope
m.nnoremap(
	"<leader>f",
	"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown())<cr>",
	opts
)
m.nnoremap("<leader>g", "<cmd>Telescope live_grep<cr>", "silent")
m.nnoremap("<leader>po", "<cmd>Telescope projects<cr>", "silent")

-- Tagbar
m.nnoremap("<leader>t", "<cmd>TagbarToggle<cr>", "silent")

-- Formatting
m.nnoremap("<leader>o", "<cmd>CocCommand java.action.organizeImports<cr>", "silent")

-- Coc
m.nnoremap("<C-space>", "<cmd>CodeActionMenu<cr>", "silent")

-- Debugging
m.nnoremap("<C-b>", "<cmd>call vimspector#ToggleBreakpoint()<cr>", "silent")
m.nnoremap("<F5>", "<cmd>call vimspector#Continue()<cr>", "silent")
m.nnoremap("<F10>", "<cmd>call vimspector#StepOver()<cr>", "silent")
m.nnoremap("<F11>", "<cmd>call vimspector#StepInto()<cr>", "silent")
m.nnoremap("<S-F11>", "<cmd>call vimspector#StepOut()<cr>", "silent")
m.nnoremap("dq", "<cmd>VimspectorReset<cr>", "silent")
m.nnoremap("<F2>", "<cmd>FloatermNew --autoclose=2 --silent mvn -Dmaven.surefire.debug test<cr>", opts)
