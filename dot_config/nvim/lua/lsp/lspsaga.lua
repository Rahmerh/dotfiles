local saga = require("lspsaga")
local icons = require("core.icons")

saga.setup({
    error_sign = icons.diagnostics.Error,
    warn_sign = icons.diagnostics.Warning,
    hint_sign = icons.diagnostics.Hint,
    infor_sign = icons.diagnostics.Information,
    code_action_prompt = {
        enable = false,
    },
})
