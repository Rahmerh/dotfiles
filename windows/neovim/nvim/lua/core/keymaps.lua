local options = { noremap = true, silent = true }

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<Space>", "<Nop>", options)

-- Buffers
vim.keymap.set("n", "<S-h>", "<cmd>JABSOpen<cr>", options)

vim.keymap.set("n", "<S-q>", "<cmd>bd<cr>", options)
vim.keymap.set("n", "<S-l>", "<cmd>e#<cr>", options)

vim.keymap.set("n", "<leader>s", "<cmd>WinShift<cr>", options)

vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)

vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

-- Editing/movement
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

-- Yanking & pasting
vim.keymap.set("x", "<C-p>", [["_dP]])

vim.keymap.set("v", "<leader>y", [["+y]], options)
vim.keymap.set("n", "<leader>y", [["+y]], options)
vim.keymap.set("n", "<leader>Y", [["+Y]], options)

vim.keymap.set("v", "<leader>p", [["+p]], options)
vim.keymap.set("n", "<leader>p", [["+p]], options)
vim.keymap.set("n", "<leader>P", [["+P]], options)

-- Harpoon
vim.keymap.set("n", "<leader>h", "<cmd>lua require('harpoon.mark').add_file()<cr>", options)
vim.keymap.set("n", "<C-p>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", options)

-- Terminal
vim.keymap.set("n", "<C-\\>", "<cmd>FloatermToggle<cr>", options)
vim.keymap.set("t", "<C-\\>", "<C-h><C-n><cmd>FloatermHide<cr>", options)

vim.keymap.set("n", "<C-_>", "<cmd>FloatermNew lazygit<cr>", options)

vim.keymap.set("n", "<leader>e", "<cmd>FloatermNew yazi<cr>", options)

-- Fuzzy search
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>", ooptionsns)
vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>", options)

-- Debugging
vim.keymap.set("n", "<F1>", "<cmd>JdtUpdateDebugConfig<cr>", options)
vim.keymap.set("n", "<F5>", "<cmd>DapContinue<cr>", options)
vim.keymap.set("n", "<F10>", "<cmd>DapStepOver<cr>", options)
vim.keymap.set("n", "<F11>", "<cmd>DapStepInto<cr>", options)
vim.keymap.set("n", "<F23>", "<cmd>DapStepOut<cr>", options) -- S-F11
vim.keymap.set("n", "<F17>", "<cmd>DapTerminate<cr>", options) -- S-F5
vim.keymap.set("n", "<leader>b", "<cmd>PBToggleBreakpoint<cr>", options)
vim.keymap.set("n", "td", "<cmd>lua require'jdtls'.test_nearest_method()<cr>", options)
vim.keymap.set("n", "tc", "<cmd>lua require'jdtls'.test_class()<cr>", options)
vim.keymap.set("n", "dt", "<cmd>DapToggleRepl<cr>", options)
vim.keymap.set("n", "ev", "<cmd>lua require('dapui').eval()<cr><cmd>lua require('dapui').eval()<cr>", options)
vim.keymap.set("v", "ev", "<cmd>lua require('dapui').eval()<cr><cmd>lua require('dapui').eval()<cr>", options)

-- LSP
vim.keymap.set({ "v", "n" }, "<A-cr>", require("actions-preview").code_actions)

vim.keymap.set("n", "gi", vim.lsp.buf.implementation, options)
vim.keymap.set("n", "gr", vim.lsp.buf.references, options)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, options)

vim.keymap.set("n", "<leader>dt", "<cmd>Trouble diagnostics win = { type = 'split', position='right'}<cr>", options)

vim.keymap.set("n", "<C-f>", "<cmd>Format<cr>", options)

-- Misc
vim.keymap.set("n", "<C-y>", require("telescope").extensions.nerdy.nerdy, options)

-- Java
vim.keymap.set("n", "<C-b>", "<cmd>JdtCompile<cr>", options)

-- Copilot
vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<CR>", options)
