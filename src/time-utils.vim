fun! Ts2Secs(ts)
    let l:gs = matchlist(a:ts, '^\(\d\{-}\):\(\d\{-}\)$')

    return 3600 * l:gs[1] + 60 * l:gs[2]
endfun

fun! Secs2Ts(secs)
    let l:hs = a:secs / 3600
    let l:ms = (a:secs % 3600) / 60

    if strlen(l:hs) == 1
        let l:hs = '0' . l:hs
    endif
    if strlen(l:ms) == 1
        let l:ms = '0' . l:ms
    endif

    return l:hs . ':' . l:ms
endfun
