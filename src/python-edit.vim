source ./ezopfun.vim

let maplocalleader = 'ò'

au filetype python nnoremap <localleader><localleader> :call PythonNextPlaceholder()<cr>
au filetype python nnoremap <localleader>F mm:call InsertFuncSnippet()<cr>`mi

" test
func! Test(...)
    echom a:1 
endfunc

" TODO/CC
OpMap <leader>T Test
