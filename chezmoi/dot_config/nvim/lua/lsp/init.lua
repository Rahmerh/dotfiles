require("lsp.autopairs")
require("lsp.mason")
require("lsp.cmp")
require("lsp.lspsaga")
require("lsp.dap")
require("lsp.null-ls")
local handlers = require("lsp.handlers")

handlers.enable_format_on_save()
