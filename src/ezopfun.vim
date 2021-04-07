func! PythonNextPlaceholder()
    call search('<-->')
    execute 'normal! diW'
    startinsert!
endfunc

func! s:MapOverOp(fn, type, ...)
    let sel_save = &selection
    let &selection = 'inclusive'
    let reg_save = @@

    if a:0  " Invoked from Visual mode, use gv command.
        silent exe 'normal! gvy'
    elseif a:type == 'line'
        silent exe "normal! '[V']y"
    else
        silent exe 'normal! `[v`]y'
    endif

    call a:fn(@@)

    let &selection = sel_save
    let @@ = reg_save
endfunc

func! SetOpFun(fn)
    let s:fn = a:fn
    func! OpFun(type, ...)
        call function('s:MapOverOp', [s:fn, a:type] + a:000)()
    endfunc
    set opfunc=OpFun
endfunc

func! SetOpFunV(fn)
    call s:MapOverOp(a:fn, visualmode(), 1)
endfunc

func! SetOpNorm(norm_comm)
    let s:norm_comm = a:norm_comm
    func! OpFun(type, ...)
        func! NormFun(sel)
            " NB. Using `a:sel` directly in mapings seems to magically work...
            "     I'm leaving this comment here for eventual magical errors
            "     in the future that might require a `g:sel` comeback.
            " let g:sel = a:sel
            sil exe 'normal!' s:norm_comm
        endfunc
        call function('s:MapOverOp', [function('NormFun'), a:type] + a:000)()
    endfunc
    set opfunc=OpFun
endfunc

func! SetOpNormV(norm_comm)
    let s:norm_comm = a:norm_comm
    func! NormFun(sel)
        let g:sel = a:sel
        sil exe 'normal!' s:norm_comm
    endfunc
    call s:MapOverOp(function('NormFun'), visualmode(), 1)
endfunc

func! OpFunMap(keycomb, str_fn)
    exe 'nnoremap' a:keycomb ':call SetOpFun(function("' . a:str_fn . '"))<cr>g@'
    exe 'vnoremap' a:keycomb ':<c-u>call SetOpFunV(function("' . a:str_fn . '"))<cr>g@'
endfunc
command! -nargs=* OpFunMap call OpFunMap(<f-args>)

func! OpMap(keycomb, norm_comm)
    " So that `xnoremap` command doesn't interpret them as literal keypresses
    let l:norm_comm = substitute(a:norm_comm, '<', '<lt>', 'g')
    " So that they are ready for the subsequent `exe 'normal!' norm_comm`
    " command (see `:h expr-quote`)
    let l:norm_comm = substitute(l:norm_comm, '\(<.\{-}>\)', '\\\1', 'g')

    exe 'nnoremap' a:keycomb ':call SetOpNorm("' l:norm_comm '")<cr>g@'
    exe 'vnoremap' a:keycomb ':<c-u>call SetOpNormV("' l:norm_comm '")<cr>g@'
endfunc
command! -nargs=* OpMap call OpMap(<f-args>)

" EXAMPLES

" Paste selection at end of line
" OpMap <leader>T A<c-r>=a:sel<cr>

" Same Thing with `OpFunMap`
" func! Test(sel)
"     exe 'normal! A<c-r>=a:sel<cr>'
" endfunc
" OpFunMap <leader>Y Test
