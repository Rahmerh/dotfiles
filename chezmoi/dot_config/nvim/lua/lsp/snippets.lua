local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    vim.notify("Luasnip could not be loaded.");
    return
end

local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI"
}

require("luasnip/loaders/from_vscode").lazy_load()

luasnip.add_snippets("java", {
    s("ternary", {
        i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
    })
})

luasnip.add_snippets("java", {
    s("private_final_field", {
        t("private final "), i(1, "type"), t(" "), i(2, "name"), t(";")
    })
})
