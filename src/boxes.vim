" Boxed comments for fancy persons

func! MakeBoxMappings(ft)
    OpMap gb :
    " au filetype a:ft vnoremap gb :'<,'>!boxes -d vim<cr>
    " au filetype a:ft nnoremap gbb V:'<,'>!boxes -d vim<cr>
    " au filetype a:ft nnoremap gbm vip:'<,'>!boxes -d vim -m<cr>
endfunc

" Default
" TODO: Find out way to fallback

" VimScript
MakeBoxMappings vim vim

" Rust
au filetype rust vnoremap <leader>b :'<,'>!boxes<cr>
au filetype rust nnoremap <leader>bb V:'<,'>!boxes<cr>
au filetype rust nnoremap <leader>bm vip:'<,'>!boxes -m<cr>
au filetype rust nnoremap <leader>vg :Vimgrep 

" Haskell
au filetype haskell vnoremap <leader>b :'<,'>!boxes -d ada-box<cr>
au filetype haskell vnoremap <leader>bm V:'<,'>!boxes -m<cr>
au filetype haskell nnoremap <leader>bb V:'<,'>!boxes -d ada-box<cr>
