func! PyImport(file_to_import)
    let l:parent_module = fnamemodify(a:file_to_import, ':p:h:t')
    py3 __package__ = vim.eval('l:parent_module')
    exe 'py3f' a:file_to_import
endfunc
command! -nargs=1 PyImport call PyImport(<args>)
