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
    use("neovim/pynvim")
    use("ryanoasis/vim-devicons")
    use("kyazdani42/nvim-web-devicons")
    use("ziontee113/color-picker.nvim")
    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    })
    use 'ThePrimeagen/vim-be-good'
    use "lambdalisue/suda.vim"

    -- Startup
    use("lewis6991/impatient.nvim")

    -- Terminal
    use 'voldikss/vim-floaterm'

    -- Color scheme(s)
    use('Mofiqul/vscode.nvim')

    -- Debugger
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("mfussenegger/nvim-jdtls")
    use("Weissle/persistent-breakpoints.nvim")

    -- Git
    use { 'lewis6991/gitsigns.nvim' }

    -- Coding stuff
    use("towolf/vim-helm")
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
    use("numToStr/Comment.nvim")
    use {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl"
    }
    use "RRethy/vim-illuminate"

    -- Autocomplete
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/nvim-cmp")
    use("windwp/nvim-autopairs")
    use("saadparwaiz1/cmp_luasnip")

    -- LSP
    use("neovim/nvim-lspconfig")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("WhoIsSethDaniel/mason-tool-installer.nvim")
    use({
        "L3MON4D3/LuaSnip",
        run = "make install_jsregexp"
    })
    use "rafamadriz/friendly-snippets"
    use "folke/neodev.nvim"
    use 'rmagatti/goto-preview'
    use {
        "amrbashir/nvim-docs-view",
        opt = true,
        cmd = { "DocsViewToggle" },
        config = function()
            require("docs-view").setup {
                position = "bottom",
                width = 30,
            }
        end
    }

    -- Telescope
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-dap.nvim")
    use("nvim-telescope/telescope-ui-select.nvim")

    -- Treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    -- All about buffers
    use("petertriho/nvim-scrollbar")
    use 'johann2357/nvim-smartbufs'
    use {
        'kdheepak/tabline.nvim',
        requires = { { 'hoob3rt/lualine.nvim', opt = true }, { 'kyazdani42/nvim-web-devicons', opt = true } }
    }
    use {
        "Djancyp/outline",
        config = function()
            require('outline').setup()
        end
    }
    use 'ThePrimeagen/harpoon'

    use {
        'chipsenkbeil/distant.nvim',
        branch = 'v0.3',
        config = function()
            require('distant'):setup()
        end
    }

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
