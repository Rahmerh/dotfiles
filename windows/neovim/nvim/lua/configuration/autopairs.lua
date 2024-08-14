local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
    vim.notify("Autopairs not found!")
    return
end

autopairs.setup()

local ts_conds = require("nvim-autopairs.ts-conds")
local rule = require("nvim-autopairs.rule")

-- press % => %% only while inside a comment or string
autopairs.add_rules({
    rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
    rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
})
