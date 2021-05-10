nnoremap <leader>. :cd %:p:h<cr>:pwd<cr>
nnoremap <leader>- :pwd<cr>

nnoremap <leader>R :Ranger<cr>

" Easily diff two files
fun OpenDiff(file1, file2)
    exe 'tabnew' a:file1
    exe 'diffsplit' a:file2
endfun

command! -nargs=* -complete=arglist OpenDiff call OpenDiff(<f-args>)

nnoremap <leader>od :OpenDiff<space>
