local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.stylua,
		formatting.google_java_format.with({ extra_args = { "-a" } }),
		formatting.beautysh,
		diagnostics.hadolint,
		diagnostics.markdownlint,
		diagnostics.semgrep.with({ extra_args = { "--config", "auto", "-q", "--json", "$FILENAME" } }),
	},
})