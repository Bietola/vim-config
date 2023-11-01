source ./quoteutils.vim
source ./funutils.vim
source ./pyimport.vim
PyImport './py/vim_utils.py'

""""""""""""""""
" Local Leader "
""""""""""""""""

" TODO: Educate on localleaders
au BufEnter * if &buftype == 'terminal' | let maplocalleader = 'ò' | endif

"""""""""""""""""""""""""""""""""""""""
" Open and Find Already Open Terminal "
"""""""""""""""""""""""""""""""""""""""

func! OpenTermBuf()
    let l:term_buf = FindNextTermBuf()

    exe 'echom "Switching to: ' . l:term_buf . '"'
    exe 'b ' . l:term_buf
endfunc

func! FindNextTermBuf()
    return py3eval('find_next_term_buf()')
endfunc
command! FindNextTermBuf call FindNextTermBuf()

func! GotoTermBuf()
    let l:term_buf = FindNextTermBuf()

    exe 'echom "Jumping to: ' . l:term_buf . '"'
    call win_gotoid(win_findbuf(l:term_buf))
endfunc

for [cmd, when_inside_term] in [['t', 'i'], ['l', 'i!!<cr>']]
exe 'nnoremap <leader>' . cmd . 'i :call OpenTermBuf()<cr>'                    . when_inside_term
exe 'nnoremap <leader>' . cmd . 't :tabnew<cr>:call OpenTermBuf()<cr>'         . when_inside_term
exe 'nnoremap <leader>' . cmd . 'v <c-w>v:call OpenTermBuf()<cr>'              . when_inside_term
exe 'nnoremap <leader>' . cmd . 'S <c-w>S<c-w>J:call OpenTermBuf()<cr>'        . when_inside_term
exe 'nnoremap <leader>' . cmd . 's <c-w>S<c-w>J8<c-w>-:call OpenTermBuf()<cr>' . when_inside_term
endfor

nnoremap <c-space> <c-w>S<c-w>J:call OpenTermBuf()<cr>i

"""""""""""""""""
" Misc Mappings "
"""""""""""""""""

" Make mapping that activates when inside a terminal
fun! TermMap(keycomb, effect, normal=v:false)
    let l:mapping_args = join([a:keycomb, a:effect], ' ')

    " t-mode is practically terminal insert mode
    exe 'tnoremap' l:mapping_args

    " Make buffer specific normal mode kbs
    if a:normal
        augroup term
            au!
            " au BufEnter * if &buftype == 'terminal' | exe 'nnoremap <buffer>' l:mapping_args | endif
            exe 'au TermOpen * nnoremap <buffer>' l:mapping_args
        augroup END
    endif
endfun

call TermMap('<localleader>e', '<c-\><c-n>')
call TermMap('<localleader>q', '<c-\><c-n>:q<cr>')
call TermMap('<localleader>k', '<c-\><c-n>/]\$<cr>NNzt', v:true)
call TermMap('<c-space>', '<c-\><c-n>:q<cr>', v:true)

" Get terminal job id
call TermMap('<localleader>j', ':echo "terminal job id:" b:terminal_job_id<cr>')
