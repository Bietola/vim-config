py3file ./py/utils.py

func OpenTermBuf()
    redir => l:term_buf
    py3 print(next(find_term_buffers()).number)
    redir END
    let l:term_buf = l:term_buf[1:]

    exe 'echom "there you go: ' . l:term_buf . '"'
    exe 'b ' . l:term_buf
endfunc

for [cmd, when_inside_term] in [['t', 'i'], ['l', 'i!!<cr>']]
exe 'nnoremap <leader>' . cmd . 'i :call OpenTermBuf()<cr>'                    . when_inside_term
exe 'nnoremap <leader>' . cmd . 't :tabnew<cr>:call OpenTermBuf()<cr>'         . when_inside_term
exe 'nnoremap <leader>' . cmd . 'v <c-w>V:call OpenTermBuf()<cr>'              . when_inside_term
exe 'nnoremap <leader>' . cmd . 'S <c-w>S<c-w>J:call OpenTermBuf()<cr>'        . when_inside_term
exe 'nnoremap <leader>' . cmd . 's <c-w>S<c-w>J8<c-w>-:call OpenTermBuf()<cr>' . when_inside_term
endfor

tnoremap <leader>q <c-\><c-n>:q<cr>
