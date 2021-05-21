" Boxed comments for fancy persons

source ./ezopfun.vim

func! MakeBoxMappings(box_design = 'c')
    let l:flags = []

    " Box design
    call add(l:flags, '-d ' . a:box_design)

    " Box creation command
    call OpMap('gb', ':''<,''>!/sul/boxes ' . join(l:flags, ' ') . '<cr>', 'v_')

    " Box mend command
    call add(l:flags, '-m')
    call OpMap('gbm', ':''<,''>!/sul/boxes ' . join(l:flags, ' ') . '<cr>', 'v_')
endfunc

" Default
" TODO: Find out way to fallback

" VimScript
au filetype vim call MakeBoxMappings('vim-box')

" Rust
" TODO: Modernize
au filetype rust vnoremap <leader>b :'<,'>!boxes<cr>
au filetype rust nnoremap <leader>bb V:'<,'>!boxes<cr>
au filetype rust nnoremap <leader>bm vip:'<,'>!boxes -m<cr>
au filetype rust nnoremap <leader>vg :Vimgrep 

" Haskell
au filetype haskell call MakeBoxMappings('ada-box')

" Ultisnips
au filetype snippets call MakeBoxMappings('shell')
