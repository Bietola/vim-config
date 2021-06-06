"""""""""""""""""
" Quote Symbols "
"""""""""""""""""

fun! Sorround(c, str)
    return a:c . a:str . a:c
endfun

fun! Quote(str)
    return Sorround('''', a:str)
endfun

fun! DQuote(str)
    return Sorround('"', a:str)
endfun

"""""""""""""""""""
" Quote Functions "
"""""""""""""""""""

fun! StrFun(fun_name, ...)
    return a:fun_name . '(' . join(a:000, ', ') . ')'
endfun

fun! StrFunQ(fun_name, ...)
    return function('StrFun', [a:fun_name] + Map({ arg -> '''' . arg . '''' }, a:000))()
endfun

fun! StrFunDQ(fun_name, ...)
    return function('StrFun', [a:fun_name] + Map({ arg -> '"' . arg . '"' }, a:000))()
endfun
