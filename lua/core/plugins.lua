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
	use("nvim-lualine/lualine.nvim")
	use("ahmedkhalf/project.nvim")
	use("kkharji/sqlite.lua")
	use("spinks/vim-leader-guide")
	use("neovim/pynvim")
	use("sudormrfbin/cheatsheet.nvim")
	use("xiyaowong/link-visitor.nvim")

	-- Keymappings
	use("b0o/mapx.nvim")
	use("folke/which-key.nvim")

	-- Color scheme(s)
	use("sainnhe/sonokai")

	-- Debugger
	use("puremourning/vimspector")

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
	use("preservim/tagbar")
	use("nvim-treesitter/nvim-treesitter-angular")

	-- Git
	use("kdheepak/lazygit.nvim")

	-- Nvimtree
	use("kyazdani42/nvim-web-devicons")
	use({
		"kyazdani42/nvim-tree.lua",
		tag = "nightly",
	})
	use("jghauser/mkdir.nvim")

	-- All about buffers
	use("noib3/nvim-cokeline")
	use("famiu/bufdelete.nvim")
	use({
		"ghillb/cybu.nvim",
		branch = "main",
	})
	use("nkakouros-original/numbers.nvim")
	use("numToStr/Comment.nvim")

	-- Helm
	use("towolf/vim-helm")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
