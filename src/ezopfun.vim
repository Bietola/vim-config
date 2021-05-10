source ./funutils.vim

" Utility
func! s:VisualSelect(beg, end)
    " See `:h getpos()` and `:h cursor({list})`
    " Use last visual mode
    cursor(a:beg[1:])
    exe 'normal' visualmode()
    cursor(a:end[1:])
endfunc

func! s:MapOverOp(fn, motion_key, type, ...)
    let sel_save = &selection
    let &selection = 'inclusive'
    let reg_save = @@

    " Save selection range
    let l:sel_start = getpos("`[")
    let l:sel_end = getpos("`]")

    if a:0  " Invoked from Visual mode, use gv command.
        silent exe 'normal! gv' . a:motion_key
    elseif a:type == 'line'
        silent exe "normal! '[V']" . a:motion_key
    else
        silent exe 'normal! `[v`]' . a:motion_key
    endif

    call a:fn(@@, sel_start, sel_end)

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

func! SetOpNorm(norm_comm, motion_key = 'y', end_w_insert = '', do_selection = v:false)
    func! OpFun(type, ...) closure
        func! NormFun(sel_v, sel_beg, sel_end) closure
            " Do visual mode selection before executing command if required
            if a:do_selection
                call s:VisualSelect(a:sel_beg, a:sel_end)
            endif
                
            " NB. Using `a:sel_v` directly in mapings seems to magically work...
            "     I'm leaving this comment here for eventual magical errors
            "     in the future that might require a `g:sel_v` comeback.
            " let g:sel_v = a:sel_v
            "
            " ANB. Same for `sel_beg` and `sel_end`
            sil exe 'normal!' a:norm_comm

            if a:end_w_insert ==# 'i'
                startinsert
            elseif a:end_w_insert ==# 'A'
                startinsert!
            endif

            " This was needed for some unknown reason in the past...
            " Leaving it for future fuckups
            " sil exe "normal! \<del>"
        endfunc
        call function('s:MapOverOp', [function('NormFun'), a:motion_key, a:type] + a:000)()
    endfunc
    set opfunc=OpFun
endfunc

func! SetOpNormV(norm_comm, motion_key = 'y', end_w_insert = '', do_selection = v:false)
    func! NormFun(sel) closure
        " Do visual mode selection before executing command if required
        if a:do_selection
            s:VisualSelect(a:sel_beg, a:sel_end)
        endif
            
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
    let l:do_selection = v:false
    let l:quick_line_motion = v:true
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
        if l:flag ==# 'v'
            let l:do_selection = v:true
        endif
        if l:flag ==# 'A'
            let l:end_w_insert = 'A'
        endif
        if l:flag ==# '_'
            let l:quick_line_motion = v:true
        endif
    endfor

    " Conventional motion mappings
    exe 'nnoremap' a:keycomb ':call' StrFunDQ('SetOpNorm', l:norm_comm, l:motion_key, l:end_w_insert, l:do_selection) '<cr>g@'
    exe 'vnoremap' a:keycomb ':<c-u>call' StrFunDQ('SetOpNormV', l:norm_comm, l:motion_key, l:end_w_insert, l:do_selection) '<cr>g@'
    " Extra custom mappings
    let l:last_key_in_comb = a:keycomb[len(a:keycomb) - 1]
    " TODO: Make global util array of motions
    if l:quick_line_motion
    " Entire line motion if not already taken
    " if index(['w', 'l', 'e', 'f', 'b', 'i', 'a', '_'], l:last_key_in_comb) == -1
        exe 'nnoremap' a:keycomb . l:last_key_in_comb ':call' StrFunDQ('SetOpNorm', l:norm_comm, l:motion_key, l:end_w_insert, l:do_selection) '<cr>g@_'
    " endif
    endif
endfunc
command! -nargs=* OpMap call OpMap(<f-args>)

" EXAMPLES

" Paste selection at end of line
OpMap <leader>Ta A<space><c-r>=a:sel_v<cr> d_
nmap <leader>Tb <leader>TaW

" Substitute everything within selection with `lol`
" TODO/CC: Make this test 
OpMap <leader>Tc :'<,'>s/e/E/g<cr> v

" " Same Thing with `OpFunMap`
" func! Test(sel_v, sel_beg, sel_end)
"     exe 'normal! A<c-r>=a:sel_v<cr>'
" endfunc
OpFunMap <leader>Td Test
