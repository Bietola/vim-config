" hello
function DoTest()
    let l:file = readfile(expand('%'))
    for line in l:file
        if len(matchlist(line, '\v^" hello$'))
            echom(line)
        endif
    endfor
endfunction
