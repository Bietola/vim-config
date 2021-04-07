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

func! SetOpFun(fn_str)
    let s:fn_str = a:fn_str
    func! OpFun(type, ...)
        call function('s:MapOverOp', [function(s:fn_str), a:type] + a:000)()
    endfunc
    set opfunc=OpFun
endfunc
command! -nargs=1 SetOpFun call SetOpFun('<args>')

func! SetOpFunV(fn_str)
    call s:MapOverOp(function(s:fn_str), visualmode(), 1)
endfunc
command! -nargs=1 SetOpFunV call SetOpFunV('<args>')

func! OpMap(keycomb, str_fn)
    exe 'nnoremap' a:keycomb ':SetOpFun' a:str_fn '<cr>g@'
    exe 'vnoremap' a:keycomb ':<c-u>SetOpFunV' a:str_fn '<cr>g@'
endfunc
command -nargs=* OpMap call OpMap(<f-args>)
