let maplocalleader = 'ò'

func PythonNextPlaceholder()
    call search('<-->')
    execute 'normal! diW'
    startinsert!
endfunc

au filetype python nnoremap <localleader><localleader> :call PythonNextPlaceholder()<cr>
au filetype python nnoremap <localleader>F mmi(<cr><esc>A,<cr>)<esc>O<--><esc>`m
