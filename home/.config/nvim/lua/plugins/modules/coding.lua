return {
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("Comment").setup({
                toggler = {
                    line = "<leader>k",
                },
                opleader = {
                    line = "<leader>u",
                },
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "BufReadPre",
        config = function()
            vim.opt.list = true
            require("ibl").setup()
        end,
    },
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("illuminate").configure({
                providers = {
                    "lsp",
                    "treesitter",
                    "regex",
                },
                delay = 0,
            })
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")

            npairs.setup({
                check_ts = true,
                ts_config = {
                    lua = { "string", "source" },
                    javascript = { "string", "template_string" },
                    java = false,
                },
                disable_filetype = { "TelescopePrompt", "spectre_panel" },
                fast_wrap = {
                    map = "<M-e>",
                    chars = { "{", "[", "(", '"', "'" },
                    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                    offset = 0,
                    end_key = "$",
                    keys = "qwertyuiopzxcvbnmasdfghjkl",
                    check_comma = true,
                    highlight = "PmenuSel",
                    highlight_grey = "LineNr",
                },
            })

            -- CMP integration
            local cmp_status, cmp = pcall(require, "cmp")
            if cmp_status then
                local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
            end
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            "windwp/nvim-autopairs",
        },
        config = function()
            local cmp_status_ok, cmp = pcall(require, "cmp")
            if not cmp_status_ok then
                vim.notify("Cmp not found")
                return
            end

            local snip_status_ok, luasnip = pcall(require, "luasnip")
            if not snip_status_ok then
                vim.notify("Luasnip not found")
                return
            end

            local has_words_before = function()
                local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_text(0, line - 1, col - 1, line - 1, col, {})[1]:match("%s") == nil
            end

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable,
                    ["<C-e>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sources = {
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                experimental = {
                    ghost_text = true,
                    native_menu = false,
                },
            })

            -- Autopairs integration
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
        end,
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "rouge8/neotest-rust"
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-rust")({
                        args = { "--no-capture" },
                        dap_adapter = "codelldb",
                    })
                }
            })

            vim.keymap.set("n", "<leader>tn", function() require("neotest").run.run() end)
            vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end)
            vim.keymap.set("n", "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end)
            vim.keymap.set("n", "<leader>to", function() require("neotest").output.open({ enter = true }) end)
            vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end)
        end
    },
    {
        "andythigpen/nvim-coverage",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local cov = require("coverage")

            cov.setup({
                auto_reload = true,
            })

            local function find_lcov_file()
                local candidates = {
                    "target/llvm-cov/lcov.info",
                    "coverage/lcov.info",
                    "coverage.info",
                    "lcov.info",
                }

                for _, path in ipairs(candidates) do
                    if vim.fn.filereadable(path) == 1 then
                        return path
                    end
                end

                return nil
            end

            local loaded = false

            local function toggle_coverage()
                if loaded then
                    cov.clear()
                    loaded = false
                else
                    local path = find_lcov_file()
                    if path then
                        cov.load_lcov(path, true)
                        loaded = true
                    else
                        vim.notify("No lcov file found", vim.log.levels.WARN)
                    end
                end
            end

            vim.keymap.set("n", "<leader>cv", toggle_coverage, { desc = "Toggle code coverage" })
            vim.keymap.set("n", "<leader>cs", cov.summary, { desc = "Show coverage summary" })

            vim.keymap.set("n", "<leader>cc", function()
                local ft = vim.bo.filetype
                local cmd, output

                vim.notify("Coverage generating...", vim.log.levels.INFO)

                if ft == "rust" then
                    vim.fn.mkdir("target/llvm-cov", "p")
                    cmd = {
                        "cargo", "llvm-cov", "nextest",
                        "--lcov", "--output-path", "target/llvm-cov/lcov.info"
                    }
                    output = "target/llvm-cov/lcov.info"
                else
                    vim.notify("No coverage generator for filetype: " .. ft, vim.log.levels.WARN)
                    return
                end

                vim.system(cmd, { text = true }, function(res)
                    vim.schedule(function()
                        if res.code == 0 then
                            vim.notify("Coverage generated: " .. output, vim.log.levels.INFO)
                        else
                            vim.notify("Coverage failed:\n" .. res.stderr, vim.log.levels.ERROR)
                        end
                    end)
                end)
            end, { desc = "Generate LCOV coverage" })
        end,
    }
}
