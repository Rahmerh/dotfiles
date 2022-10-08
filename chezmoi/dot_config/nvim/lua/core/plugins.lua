local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	-- Packer & misc
	use("wbthomason/packer.nvim")
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")
	use("lewis6991/impatient.nvim")
	use("goolord/alpha-nvim")
	use("antoinemadec/FixCursorHold.nvim")
	use("spinks/vim-leader-guide")
	use("neovim/pynvim")
	use("numToStr/Comment.nvim")
	use("ryanoasis/vim-devicons")
	use("kyazdani42/nvim-web-devicons")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- Terminal
	use("numToStr/FTerm.nvim")

	-- Music
	use({
		"KadoBOT/nvim-spotify",
		requires = "nvim-telescope/telescope.nvim",
		config = function()
			local spotify = require("nvim-spotify")

			spotify.setup({
				-- default opts
				status = {
					update_interval = 10000, -- the interval (ms) to check for what's currently playing
					format = "%s %t by %a", -- spotify-tui --format argument
				},
			})
		end,
		run = "make",
	})

	-- Web development
	use("ziontee113/color-picker.nvim")
	use({
		"akinsho/flutter-tools.nvim",
		config = function()
			require("flutter-tools").setup({
				widget_guides = {
					enabled = true,
				},
			})
		end,
	})

	-- Key mappings
	use("b0o/mapx.nvim")
	use("folke/which-key.nvim")

	-- Color scheme(s)
	use("Mofiqul/vscode.nvim")

	-- Debugger
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use("mfussenegger/nvim-jdtls")
	use("Weissle/persistent-breakpoints.nvim")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("lukas-reineke/lsp-format.nvim")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("L3MON4D3/LuaSnip")
	use("windwp/nvim-autopairs")
	use("MunifTanjim/prettier.nvim")
	use({
		"amrbashir/nvim-docs-view",
		opt = true,
		cmd = { "DocsViewToggle" },
		config = function()
			require("docs-view").setup({
				position = "bottom",
				height = 20,
			})
		end,
	})
	use("jose-elias-alvarez/null-ls.nvim")
	use("RRethy/vim-illuminate")

	-- Tree
	use({
		"kyazdani42/nvim-tree.lua",
		tag = "nightly",
	})

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-dap.nvim")
	use("nvim-telescope/telescope-ui-select.nvim")

	-- Statusline
	use({
		"tamton-aquib/staline.nvim",
		config = function()
			require("staline").setup()
		end,
	})

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter")
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/nvim-treesitter-angular")

	-- All about buffers
	use("romgrk/barbar.nvim")
	use("famiu/bufdelete.nvim")
	use({
		"ghillb/cybu.nvim",
		branch = "main",
	})
	use("petertriho/nvim-scrollbar")
	use({ "kevinhwang91/nvim-hlslens" })
	use("gaborvecsei/memento.nvim")

	-- Helm
	use("towolf/vim-helm")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
