source ./ezopfun.vim

let maplocalleader = 'ò'

" func! Lamb(sel)
"     exe "normal! ifstream\<c-r>=UltiSnips#ExpandSnippet()\<cr>\<c-r>=a:sel\<cr>\<c-r>=UltiSnips#JumpForwards()\<cr>\<bs>"
"     startinsert
" endfunc
" OpFunMap <localleader>F Lamb

OpMap <localleader>F ifstream<c-r>=UltiSnips#ExpandSnippet()<cr><c-r>=a:sel<cr><c-r>=UltiSnips#JumpForwards()<cr>

