local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local prettier_status_ok, prettier = pcall(require, "prettier")
if not prettier_status_ok then
	return
end

prettier.setup({
	cli_options = {
		-- https://prettier.io/docs/en/cli.html#--config-precedence
		config_precedence = "file-override",
	},
})

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = true,
	sources = {
		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.stylua,
		formatting.beautysh,
		formatting.dart_format,
		--[[ formatting.uncrustify, ]]
		formatting.tidy,
		diagnostics.hadolint,
		diagnostics.semgrep.with({ extra_args = { "--config", "auto", "-q", "--json", "$FILENAME" } }),
	},
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format { async = false }")
		end
	end,
})
