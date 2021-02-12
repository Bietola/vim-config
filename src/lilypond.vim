"""""""""""""
" Functions "
"""""""""""""

function LyPlay(starting_bar)
    let a:starting_bar = 'Norhing'

    return "WIP"
endfunction

"""""""""""""""
" Keybindings "
"""""""""""""""

" Local leader
au filetype lilypond let maplocalleader = "ò"

" Compile current file
au filetype lilypond nnoremap <localleader>c :w<cr>:!lilypond %<cr>

" View pdf associated with current file
au filetype lilypond nnoremap <localleader>v :!zathura %:r.pdf &<cr>

" Play all file with midi
au filetype lilypond nnoremap <localleader>p :!timidity %:r.midi<cr>

" Vim-surround settings
nmap s ys
au FileType lilypond let b:surround_45 = "<< \r >>"
