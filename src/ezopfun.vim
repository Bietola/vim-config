source ./funutils.vim

func! PythonNextPlaceholder()
    call search('<-->')
    execute 'normal! diW'
    startinsert!
endfunc

func! s:MapOverOp(fn, motion_key, type, ...)
    let sel_save = &selection
    let &selection = 'inclusive'
    let reg_save = @@

    if a:0  " Invoked from Visual mode, use gv command.
        silent exe 'normal! gv' . a:motion_key
    elseif a:type == 'line'
        silent exe "normal! '[V']" . a:motion_key
    else
        silent exe 'normal! `[v`]' . a:motion_key
    endif

    call a:fn(@@)

    let &selection = sel_save
    let @@ = reg_save
endfunc

func! SetOpFun(fn, motion_key = 'y')
    func! OpFun(type, ...) closure
        call function('s:MapOverOp', [a:fn, a:motion_key, a:type] + a:000)()
    endfunc
    set opfunc=OpFun
endfunc

func! SetOpFunV(fn, motion_key = 'y')
    call s:MapOverOp(a:fn, a:motion_key, visualmode(), 1)
endfunc

func! SetOpNorm(norm_comm, motion_key = 'y', end_w_insert = '')
    func! OpFun(type, ...) closure
        func! NormFun(sel) closure
            " NB. Using `a:sel` directly in mapings seems to magically work...
            "     I'm leaving this comment here for eventual magical errors
            "     in the future that might require a `g:sel` comeback.
            " let g:sel = a:sel
            sil exe 'normal!' a:norm_comm

            if a:end_w_insert ==# 'i'
                startinsert
            elseif a:end_w_insert ==# 'A'
                startinsert!
            endif
            " Find out why this is needed...
            " sil exe "normal! \<del>"
        endfunc
        call function('s:MapOverOp', [function('NormFun'), a:motion_key, a:type] + a:000)()
    endfunc
    set opfunc=OpFun
endfunc

func! SetOpNormV(norm_comm, motion_key = 'y', end_w_insert = '')
    func! NormFun(sel) closure
        sil exe 'normal!' a:norm_comm
    endfunc
    call s:MapOverOp(function('NormFun'), a:motion_key, visualmode(), 1)
endfunc

func! OpFunMap(keycomb, str_fn, motion_key = 'y')
    exe 'nnoremap' a:keycomb ':call' StrFunDQ('SetOpFun', a:str_fn, a:motion_key) '<cr>g@'
    exe 'vnoremap' a:keycomb ':<c-u>call' StrFunDQ('SetOpFunV', a:str_fn, a:motion_key) '<cr>g@'
endfunc
command! -nargs=* OpFunMap call OpFunMap(<f-args>)

func! OpMap(keycomb, norm_comm, flags = '')
    " So that `*noremap` commands don't interpret them as literal keypresses
    let l:norm_comm = substitute(a:norm_comm, '<', '<lt>', 'g')
    " So that they are ready for the subsequent `exe 'normal!' norm_comm`
    " command (see `:h expr-quote`)
    let l:norm_comm = substitute(l:norm_comm, '\(<.\{-}>\)', '\\\1', 'g')

    " Parse flags
    let l:motion_key = 'y'
    let l:end_w_insert = ''
    for l:flag in split(a:flags, '\zs')
        if l:flag ==# 'y'
            let l:motion_key = 'y'
        endif
        if l:flag ==# 'd'
            let l:motion_key = 'd'
        endif
        if l:flag ==# 'i'
            let l:end_w_insert = 'i'
        endif
        if l:flag ==# 'A'
            let l:end_w_insert = 'A'
        endif
    endfor

    exe 'nnoremap' a:keycomb ':call' StrFunDQ('SetOpNorm', l:norm_comm, l:motion_key, l:end_w_insert) '<cr>g@'
    exe 'vnoremap' a:keycomb ':<c-u>call' StrFunDQ('SetOpNormV', l:norm_comm, l:motion_key, l:end_w_insert) '<cr>g@'
endfunc
command! -nargs=* OpMap call OpMap(<f-args>)

" EXAMPLES

" Paste selection at end of line

OpMap <leader>T A<space><c-r>=a:sel<cr> d
nmap <leader>Y <leader>TaW

" Same Thing with `OpFunMap`
" func! Test(sel)
"     exe 'normal! A<c-r>=a:sel<cr>'
" endfunc
" OpFunMap <leader>U Test
