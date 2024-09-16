local options = {
    backup = false,
    cmdheight = 3,
    completeopt = { "menuone", "noselect" },
    conceallevel = 0,
    fileencoding = "utf-8",
    hlsearch = true,
    ignorecase = true,
    mouse = "a",
    pumheight = 10,
    showmode = false,
    showtabline = 2,
    smartcase = true,
    smartindent = true,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    termguicolors = true,
    timeoutlen = 1000,
    undofile = true,
    updatetime = 50,
    writebackup = false,
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
    cursorline = false,
    number = true,
    numberwidth = 4,
    signcolumn = "yes",
    wrap = false,
    scrolloff = 8,
    sidescrolloff = 8,
    guifont = "monospace:h17",
    nu = true,
    relativenumber = true,
    guicursor = "n-v-c-i:block",
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
vim.g.floaterm_opener = "edit"
vim.g.floaterm_height = 0.9
vim.g.floaterm_width = 0.9

vim.cmd([[
    let &shell = 'pwsh'
    let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    set shellquote= shellxquote=
]])
