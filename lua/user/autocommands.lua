vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end


  " augroup _debugging
  "   autocmd FileType java nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR> 
  "   autocmd FileType java nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR> 
  "   autocmd FileType java nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR> 
  "   autocmd FileType java nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR> 
  " augroup end

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

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

]])

vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])
