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
    use { 'kevinhwang91/nvim-hlslens' }

    -- Startup
    use("lewis6991/impatient.nvim")
    use("goolord/alpha-nvim")

    -- Terminal
    use("numToStr/FTerm.nvim")

    -- Color scheme(s)
    use("Mofiqul/vscode.nvim")

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
    use("MunifTanjim/prettier.nvim")
    use("RRethy/vim-illuminate")
    use({
        "rmagatti/goto-preview",
        config = function()
            require("goto-preview").setup({})
        end,
    })
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
    })
    use "lukas-reineke/indent-blankline.nvim"

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
    use({
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({
                text = {
                    spinner = "dots",
                },
                window = {
                    blend = 0,
                },
            })
        end,
    })
    use({
        "weilbith/nvim-code-action-menu",
        cmd = "CodeActionMenu",
    })
    use 'wiliamks/nice-reference.nvim'
    use {
        'filipdutescu/renamer.nvim',
        branch = 'master',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use "folke/neodev.nvim"

    -- File explorer
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
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("p00f/nvim-ts-rainbow")

    -- All about buffers
    use("romgrk/barbar.nvim")
    use("famiu/bufdelete.nvim")
    use("petertriho/nvim-scrollbar")

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
