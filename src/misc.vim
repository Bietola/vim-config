""""""""""""""""""""""""""""""""""
" Miscellaneous editor utilities "
""""""""""""""""""""""""""""""""""

" To lowercase (NB. `gu` is mapped to "go up")
nnoremap gl gu
vnoremap gl gu

" Parenthesis text objects don't work when there's a backslash before them
" (e.g. `\(hello there)`). These mappings make it easier to deal with this in
" a hacky way.
nnoremap <leader>( mmF(i<space><esc>`ml
nnoremap <leader>[ mmF[i<space><esc>`ml
nnoremap <leader>{ mmF{i<space><esc>`ml
nnoremap <leader>) mmF(hx`mh
nnoremap <leader>] mmF[hx`mh
nnoremap <leader>} mmF{hx`mh

" Useful padding insert motion
nnoremap <leader>O O<cr>

" Make current file executable
command! Chx !chmod +x %
nnoremap <leader>fx :Chx<cr>
