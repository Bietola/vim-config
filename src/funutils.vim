source ./quoteutils.vim

""""""""""""""""""""""
" Functional Streams "
""""""""""""""""""""""

fun! Map(fn, seq)
    let l:res = []
    for ele in a:seq
        call add(l:res, a:fn(ele))
    endfor
    return l:res
endfun

fun! Zip(...)
    let res = []
    for idx in range(max(Map({ v -> len(v) }, a:000)))
        let i_res = []
        for ai in a:000
            if len(ai) > idx
                call add(i_res, ai[idx])
            else
                call add(i_res, v:null)
            endif
        endfor
        call add(res, i_res)
    endfor
    return res
endfun

""""""""""""""""
" Dictionaries "
""""""""""""""""

fun! DictModField(dic, key, modfun)
    let l:new_dic = copy(a:dic)
    let l:new_dic[a:key] = a:modfun(a:dic[a:key])
    return l:new_dic
endfun

fun! DictSetField(dic, key, new_val)
    return DictModField(a:dic, a:key, { _ -> a:new_val })
endfun
