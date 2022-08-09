local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Markdown
keymap("n", "<C-m>", "<cmd>CocCommand markdown-preview-enhanced.openPreview<cr>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- HTOP
keymap("n", "<C-q>", ":lua _HTOP_TOGGLE()<cr>", opts)

-- Hop
keymap("n", "<C-g>", "<cmd>HopWord<cr>", opts)

-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
keymap("n", "R", "<comd>NvimTreeRefresh<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<cmd>bnext<cr>", opts)
keymap("n", "<S-h>", "<cmd>bprevious<cr>", opts)
keymap("n", "Q", "<cmd>Bdelete this<cr>", opts)
keymap("n", "QO", "<cmd>Bdelete other<cr>", opts)
keymap("n", "QQ", "<cmd>Bdelete all<cr>", opts)
keymap("n", "<C-t>", "<cmd>JABSOpen<cr>", opts)

-- Insert --
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Terminal --
keymap("n", "<C-/>", ":LazyGit<cr>", opts)
keymap("n", "<C-\\>", "<cmd>FloatermToggle<cr>", opts)
keymap("t", "<C-\\>", "<C-\\><C-N><cmd>FloatermToggle<cr>", opts)

keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Telescope
keymap(
	"n",
	"<leader>f",
	"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown())<cr>",
	opts
)
keymap("n", "<leader>g", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>po", "<cmd>Telescope projects<cr>", opts)

-- Tagbar
keymap("n", "<leader>t", "<cmd>TagbarToggle<cr>", opts)

-- Formatting
keymap("n", "<leader>o", "<cmd>CocCommand java.action.organizeImports<cr>", opts)

-- Coc
keymap("n", "<C-space>", "<cmd>CodeActionMenu<cr>", opts)

-- Debugging
keymap("n", "<C-b>", "<cmd>call vimspector#ToggleBreakpoint()<cr>", opts)
keymap("n", "<F5>", "<cmd>call vimspector#Continue()<cr>", opts)
keymap("n", "<F10>", "<cmd>call vimspector#StepOver()<cr>", opts)
keymap("n", "<F11>", "<cmd>call vimspector#StepInto()<cr>", opts)
keymap("n", "<S-F11>", "<cmd>call vimspector#StepOut()<cr>", opts)
keymap("n", "dq", "<cmd>VimspectorReset<cr>", opts)
keymap("n", "<F2>", "<cmd>FloatermNew --autoclose=2 --silent mvn -Dmaven.surefire.debug test<cr>", opts)
