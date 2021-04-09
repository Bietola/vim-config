source ./pyimport.vim
PyImport './py/vim_utils.py'

" TODO: Educate on localleaders
au BufEnter * if &buftype == 'terminal' | let maplocalleader = 'ò' | endif

func! FindNextTermBuf()
    return py3eval('find_next_term_buf()')
endfunc
command! FindNextTermBuf call FindNextTermBuf()

func! OpenTermBuf()
    let l:term_buf = FindNextTermBuf()

    exe 'echom "Switching to: ' . l:term_buf . '"'
    exe 'b ' . l:term_buf
endfunc

func! GotoTermBuf()
    let l:term_buf = FindNextTermBuf()

    exe 'echom "Jumping to: ' . l:term_buf . '"'
    call win_gotoid(win_findbuf(l:term_buf))
endfunc

for [cmd, when_inside_term] in [['t', 'i'], ['l', 'i!!<cr>']]
exe 'nnoremap <leader>' . cmd . 'i :call OpenTermBuf()<cr>'                    . when_inside_term
exe 'nnoremap <leader>' . cmd . 't :tabnew<cr>:call OpenTermBuf()<cr>'         . when_inside_term
exe 'nnoremap <leader>' . cmd . 'v <c-w>V:call OpenTermBuf()<cr>'              . when_inside_term
exe 'nnoremap <leader>' . cmd . 'S <c-w>S<c-w>J:call OpenTermBuf()<cr>'        . when_inside_term
exe 'nnoremap <leader>' . cmd . 's <c-w>S<c-w>J8<c-w>-:call OpenTermBuf()<cr>' . when_inside_term
endfor

tnoremap <localleader>e <c-\><c-n>
tnoremap <localleader>q <c-\><c-n>:q<cr>
