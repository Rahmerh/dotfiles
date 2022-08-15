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
	use("voldikss/vim-floaterm")
	use("ahmedkhalf/project.nvim")
	use("spinks/vim-leader-guide")
	use("neovim/pynvim")
	use("sudormrfbin/cheatsheet.nvim")
	use("xiyaowong/link-visitor.nvim")
	use({
		"lewis6991/spellsitter.nvim",
		config = function()
			require("spellsitter").setup()
		end,
	})
	use("moevis/base64.nvim")

	-- Web development
	use("ziontee113/color-picker.nvim")

	-- Key mappings
	use("b0o/mapx.nvim")
	use("folke/which-key.nvim")

	-- Color scheme(s)
	use("sainnhe/edge")

	-- Debugger
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use("mfussenegger/nvim-jdtls")
	use("Weissle/persistent-breakpoints.nvim")

	-- Coc
	use({
		"neoclide/coc.nvim",
		branch = "release",
	})
	use({
		"weilbith/nvim-code-action-menu",
		after = "coc.nvim",
		requires = "xiyaowong/coc-code-action-menu.nvim",
		config = function()
			require("coc-code-action-menu")
		end,
	})

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-smart-history.nvim")
	use("nvim-telescope/telescope-media-files.nvim")
	use("AckslD/nvim-neoclip.lua")
	use("kkharji/sqlite.lua")

	-- Hop
	use({
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		commit = "518e27589c0463af15463c9d675c65e464efc2fe",
	})
	use("p00f/nvim-ts-rainbow")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("nvim-treesitter/nvim-treesitter-angular")

	-- Git
	use("kdheepak/lazygit.nvim")
	use("sindrets/diffview.nvim")

	-- File explorer
	use("kyazdani42/nvim-web-devicons")
	use({
		"kyazdani42/nvim-tree.lua",
		tag = "nightly",
	})

	-- All about buffers
	use("noib3/nvim-cokeline")
	use("famiu/bufdelete.nvim")
	use({
		"ghillb/cybu.nvim",
		branch = "main",
	})
	use("nkakouros-original/numbers.nvim")
	use("numToStr/Comment.nvim")
	use({
		"tamton-aquib/staline.nvim",
		config = function()
			require("staline").setup()
		end,
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
