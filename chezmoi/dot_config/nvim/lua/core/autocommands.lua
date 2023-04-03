vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
  augroup END

  set mouse=n

  command W execute "SudaWrite"
  command E execute "SudaRead"

  augroup highlight_current_word
    au!
    au CursorHold * :exec 'match Search /\V\<' . expand('<cword>') . '\>/'
  augroup END
]])

vim.cmd([[
let g:rnvimr_hide_gitignore = 0
let g:rnvimr_enable_picker = 1
let g:rnvimr_enable_bw = 1
let g:rnvimr_layout = {
           \ 'relative': 'editor',
           \ 'width': &columns,
           \ 'height': &lines - 2,
           \ 'col': 0,
           \ 'row': 0,
           \ 'style': 'minimal'
           \ }
]])

vim.opt.laststatus = 3
