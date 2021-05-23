fun! Sorround(c, str)
    return a:c . a:str . a:c
endfun

fun! Quote(str)
    return Sorround('''', a:str)
endfun

fun! DQuote(str)
    return Sorround('"', a:str)
endfun
