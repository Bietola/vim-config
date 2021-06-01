""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Things to quickly navigate a standard stack projects "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! HaskellGoToDepsList()
    e **/package.yaml
    /dependencies:
    normal ggn
endfun

" "Open Dependencies": Open `package.yaml` and put cursor in dependecies section
au FileType haskell nnoremap <buffer> <localleader>od 
            \ :call HaskellGoToDepsList()<cr>

" "Add Dependencies"
au FileType haskell nnoremap <buffer> <localleader>Da 
            \ :call HaskellGoToDepsList()<cr>
            \ }O<esc>cc-<space>

" Use hindent to format
au filetype haskell nnoremap <buffer> <localleader>F :Hindent<cr>
