local fn = vim.fn
-- Automatically install packer local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
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
    use("numToStr/Comment.nvim")
    use("lewis6991/impatient.nvim")
    use("goolord/alpha-nvim")
    use("antoinemadec/FixCursorHold.nvim")
    use("voldikss/vim-floaterm")
    use("nvim-lualine/lualine.nvim")
    use("ahmedkhalf/project.nvim")
    use("kkharji/sqlite.lua")
    use("spinks/vim-leader-guide")
    use("neovim/pynvim")

    -- Color scheme(s)
    use("EdenEast/nightfox.nvim")
    use({ "folke/tokyonight.nvim", commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" })
    use("bluz71/vim-nightfly-guicolors")
    use("kyazdani42/blue-moon")
    use("sainnhe/sonokai")

    -- Debugger
    use("puremourning/vimspector")

    -- Coc
    use({
        "neoclide/coc.nvim",
        branch = "release"})

    -- Snippets
    use("L3MON4D3/LuaSnip")
    use("rafamadriz/friendly-snippets")

    -- Telescope
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-smart-history.nvim")
    use("nvim-telescope/telescope-media-files.nvim")

    -- Hop
    use {
        'phaazon/hop.nvim',
        branch = 'v2', config = function()
            require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    }

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
    use("lewis6991/gitsigns.nvim")
    use("kdheepak/lazygit.nvim")

    -- Nvimtree
    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
        tag = "nightly",
    })

    -- Bufferline
    use("noib3/nvim-cokeline")
    use("Asheq/close-buffers.vim")

    -- Helm
    use("towolf/vim-helm")

    -- Java

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
