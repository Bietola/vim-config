let maplocalleader = 'ò'

func! PythonNextPlaceholder()
    call search('<-->')
    execute 'normal! diW'
    startinsert!
endfunc

func! s:MapOverSel(fn, type, ...)
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

func! SetSelFun(fn_str)
    let s:fn_str = a:fn_str
    func! OpFun(type, ...)
        call function('s:MapOverSel', [function(s:fn_str), a:type] + a:000)()
    endfunc
    set opfunc=OpFun
endfunc
command! -nargs=1 SetSelFun call SetSelFun('<args>')

" func! ExpandSnipWMotion(type, ...)
"     call function('ProcessTextFromSel', [function("Test"), a:type] + a:000)()
" endfunc

au filetype python nnoremap <localleader><localleader> :call PythonNextPlaceholder()<cr>
au filetype python nnoremap <localleader>F mm:call InsertFuncSnippet()<cr>`mi

" test
func! Test(...)
    echom a:1 
endfunc

" TODO/CC
SelMap <leader>T Test

nnoremap <leader>T :SetSelFun Test<cr>g@
vnoremap <leader>T :<c-u>SetSelFunV Test<cr>g@
