require("lsp.autopairs")
require("lsp.mason")
require("lsp.cmp")
require("lsp.dap")
require("lsp.null-ls")

require("lsp_preview_hover_doc").setup({
  on_init_in_preview_window = function(bufnr)
    map(bufnr, "L", "<Cmd>wincmd p<CR>")
    map(bufnr, "H", "<Cmd>wincmd p<CR>")
    map(bufnr, "<Left>", '<Cmd>lua require("lsp_preview_hover_doc").show_prev()<CR>')
    map(bufnr, "<Right>", '<Cmd>lua require("lsp_preview_hover_doc").show_next()<CR>')
  end,
  win_opts = {
    height = 20,
    zindex = 30,
  },
})
