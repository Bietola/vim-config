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
exe 'nnoremap <leader>' . cmd . 'v <c-w>V:call OpenTermBuf()<cr>'              . when_inside_term
exe 'nnoremap <leader>' . cmd . 'S <c-w>S<c-w>J:call OpenTermBuf()<cr>'        . when_inside_term
exe 'nnoremap <leader>' . cmd . 's <c-w>S<c-w>J8<c-w>-:call OpenTermBuf()<cr>' . when_inside_term
endfor

"""""""""""""""""
" Misc Mappings "
"""""""""""""""""

" Make mapping that activates when inside a terminal
fun! TermMap(keycomb, effect, normal=v:false)
    let l:mapping_args = join([a:keycomb, a:effect], ' ')

    " t-mode is practically terminal insert mode
    exe 'tnoremap' l:mapping_args

    " TODO: Find a way to make terminal buffer mappings not overshadow other
    " mappings. An hacky way would be to save the old mapping and then restore
    " it for every term mapping defined with this function. Old mappings can
    " be extracted from `:verbose :map` output (which needs to be parsed)
    " see: https://stackoverflow.com/questions/7642746/is-there-any-way-to-view-the-currently-mapped-keys-in-vim
    " exe 'au BufEnter * if &buftype == "terminal"' '|'
    "                 \ 'echom' 
    "                     \ '"WARNING! Override of mapping"' 
    "                     \ l:mapping_args 
    "                     \ '"on ALL BUFFERS (this needs to be fixed)"' '|'
    "                 \ 'exe' '''' . 'nnoremap' l:mapping_args . '''' 
    "             \ '|' 'endif'
    " au BufLeave * if &buftype == "terminal" | echom 'welcome back from term land!' | endif
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

" tnoremap <localleader>e <c-\><c-n>
" tnoremap <localleader>q <c-\><c-n>:q<cr>
" tnoremap <localleader>k <c-\><c-n>/]\$<cr>NNzt
