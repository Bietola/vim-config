source ./ezopfun.vim

let maplocalleader = 'ò'

au filetype python OpMap <localleader>F 
    \ ifstream<c-r>=UltiSnips#ExpandSnippet()<cr>
        "\ <c-r>=a:sel<cr>
        \<esc>\"=a:sel<cr>p
        \=api
        \<c-r>=UltiSnips#JumpForwards()<cr>
    \ di
