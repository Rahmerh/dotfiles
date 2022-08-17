require("lsp.autopairs")
require("lsp.mason")
require("lsp.cmp")
require("lsp.lspsaga")
local handlers = require("lsp.handlers")

handlers.enable_format_on_save();
handlers.enable_organize_imports_on_save()
