"""""""""""""""
" Keybindings "
"""""""""""""""

" Local leader
au filetype abc let maplocalleader = "ò"

" Compile current file
au filetype abc nnoremap <localleader>c :w<cr>:!abc2ly %; lilypond %:r.ly<cr>

" View pdf associated with current file
au filetype abc nnoremap <localleader>v :!zathura %:r.pdf &<cr>

" Play all file with midi
au filetype abc nnoremap <localleader>p :!timidity %:r.midi<cr>

" Vim-surround settings
nmap s ys
au FileType abc let b:surround_45 = "<< \r >>"
