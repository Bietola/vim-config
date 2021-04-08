function! Map(fn, seq)
    let l:res = []
    for ele in a:seq
        call add(l:res, a:fn(ele))
    endfor
    return l:res
endfunction

func! StrFun(fun_name, ...)
    return a:fun_name . '(' . join(a:000, ', ') . ')'
endfunc

func! StrFunQ(fun_name, ...)
    return function('StrFun', [a:fun_name] + Map({ arg -> '''' . arg . '''' }, a:000))()
endfunc

func! StrFunDQ(fun_name, ...)
    return function('StrFun', [a:fun_name] + Map({ arg -> '"' . arg . '"' }, a:000))()
endfunc
