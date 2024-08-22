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
    use("ThePrimeagen/vim-be-good")
    use("lambdalisue/suda.vim")
    use("nvim-neotest/nvim-nio")
    use("antoinemadec/FixCursorHold.nvim")
    use("RishabhRD/popfix")
    use("MunifTanjim/nui.nvim")
    use({
        "jim-fx/sudoku.nvim",
        cmd = "Sudoku",
        config = function()
            require("sudoku").setup({})
        end,
    })
    use("2kabhishek/nerdy.nvim")
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

    -- Startup
    use("lewis6991/impatient.nvim")

    -- Git
    use("lewis6991/gitsigns.nvim")

    -- Terminal
    use("voldikss/vim-floaterm")

    -- Color scheme(s)
    use("Mofiqul/vscode.nvim")

    -- Editing plugins
    use("numToStr/Comment.nvim")
    use({
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
    })
    use("RRethy/vim-illuminate")
    use({
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,
            })
        end,
    })
    use({
        "kylechui/nvim-surround",
        tag = "*",
    })
    use("lewis6991/satellite.nvim")
    use("jghauser/mkdir.nvim")

    -- LSP
    use("neovim/nvim-lspconfig")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("WhoIsSethDaniel/mason-tool-installer.nvim")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/nvim-cmp")
    use("stevearc/conform.nvim")
    use("aznhe21/actions-preview.nvim")
    use("rmagatti/goto-preview")
    use("folke/trouble.nvim")
    use("mfussenegger/nvim-lint")
    use("rshkarin/mason-nvim-lint")
    use("nvimtools/none-ls.nvim")

    -- DAP
    use("folke/neodev.nvim")
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("mfussenegger/nvim-jdtls")
    use("Weissle/persistent-breakpoints.nvim")

    -- Telescope
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-ui-select.nvim")

    -- Syntax/highlighting
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use({
        "m-demare/hlargs.nvim",
        config = function()
            require("hlargs").setup()
        end,
    })
    use({
        "nvimdev/hlsearch.nvim",
        event = "BufRead",
        config = function()
            require("hlsearch").setup()
        end,
    })

    -- Buffers
    use("matbme/JABS.nvim")
    use("ThePrimeagen/harpoon")
    use("axkirillov/hbac.nvim")
    use("sindrets/winshift.nvim")
    use("mrjones2014/smart-splits.nvim")
    use("2kabhishek/termim.nvim")

    -- Registers
    use({
        "tversteeg/registers.nvim",
        config = function()
            require("registers").setup()
        end,
    })

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
