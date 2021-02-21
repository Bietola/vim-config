"""""""""""""""
" Keybindings "
"""""""""""""""

" Compile current file
au filetype lilypond nnoremap <leader>c :w<cr>:!lilypond %<cr>

" View pdf associated with current file
au filetype lilypond nnoremap <leader>v :!zathura %:r.pdf &<cr>

" Vim-surround settings
nmap s ys
au FileType lilypond let b:surround_45 = "<< \r >>"

""""""""""""""""""""""""""""""
" Play notes in current file "
""""""""""""""""""""""""""""""

" play selected notes
au filetype lilypond nnoremap <leader>p :set opfunc=LyPlay<CR>g@
" TODO: vmap <silent> <F4> :<C-U>call CountSpaces(visualmode(), 1)<CR>
"
" function to do heavy lifting
function! LyPlay(type)
    " Get notes specified by the motion
    if a:type == 'line'
        silent exe "normal! '[V']y"
    else
        silent exe "normal! `[v`]y"
    endif

    " Play them
    let lycommand = "!lyplay italiano do \"<->\""
    let lycommand = substitute(lycommand, "<->", @@, "")
    exe lycommand
endfunction
