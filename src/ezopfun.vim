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
    let l:fn = a:fn
    let l:motion_key = a:motion_key
    func! OpFun(type, ...)
        call function('s:MapOverOp', [l:fn, l:motion_key, a:type] + a:000)()
    endfunc
    set opfunc=OpFun
endfunc

func! SetOpFunV(fn, motion_key = 'y')
    call s:MapOverOp(a:fn, a:motion_key, visualmode(), 1)
endfunc

func! SetOpNorm(norm_comm, motion_key = 'y')
    let l:norm_comm = a:norm_comm
    let l:motion_key = a:motion_key
    func! OpFun(type, ...)
        func! NormFun(sel)
            " NB. Using `a:sel` directly in mapings seems to magically work...
            "     I'm leaving this comment here for eventual magical errors
            "     in the future that might require a `g:sel` comeback.
            " let g:sel = a:sel
            sil exe 'normal!' l:norm_comm

            " TODO: Make autoinsertmode at the end optional
            startinsert
            " Find out why this is needed...
            sil exe "normal! \<del>"
        endfunc
        call function('s:MapOverOp', [function('NormFun'), l:motion_key, a:type] + a:000)()
    endfunc
    set opfunc=OpFun
endfunc

func! SetOpNormV(norm_comm, motion_key = 'y')
    let l:norm_comm = a:norm_comm
    func! NormFun(sel)
        let g:sel = a:sel
        sil exe 'normal!' l:norm_comm
    endfunc
    call s:MapOverOp(function('NormFun'), a:motion_key, visualmode(), 1)
endfunc

func! OpFunMap(keycomb, str_fn, motion_key = 'y')
    exe 'nnoremap' a:keycomb ':call SetOpFun(function("' . a:str_fn . '"), "' . a:motion_key . '")<cr>g@'
    exe 'vnoremap' a:keycomb ':<c-u>call SetOpFunV(function("' . a:str_fn . '"), "' . a:motion_key . '")<cr>g@'
endfunc
command! -nargs=* OpFunMap call OpFunMap(<f-args>)

func! OpMap(keycomb, norm_comm, motion_key = 'y')
    " So that `xnoremap` command doesn't interpret them as literal keypresses
    let l:norm_comm = substitute(a:norm_comm, '<', '<lt>', 'g')
    " So that they are ready for the subsequent `exe 'normal!' norm_comm`
    " command (see `:h expr-quote`)
    let l:norm_comm = substitute(l:norm_comm, '\(<.\{-}>\)', '\\\1', 'g')

    exe 'nnoremap' a:keycomb ':call SetOpNorm("' l:norm_comm '", "' . a:motion_key . '")<cr>g@'
    exe 'vnoremap' a:keycomb ':<c-u>call SetOpNormV("' l:norm_comm '", "' . a:motion_key . '")<cr>g@'
endfunc
command! -nargs=* OpMap call OpMap(<f-args>)

" EXAMPLES

" Paste selection at end of line

OpMap <leader>T A<c-r>=a:sel<cr>

" Same Thing with `OpFunMap`
" func! Test(sel)
"     exe 'normal! A<c-r>=a:sel<cr>'
" endfunc
" OpFunMap <leader>Y Test
