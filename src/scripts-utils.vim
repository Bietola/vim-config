let s:this_script_path = expand('<sfile>:p')

au filetype vim let maplocalleader = 'ò'

func SourceVimrcWithoutScripts()
    let l:old = exists('g:dont_load_subscripts') ? g:dont_load_subscripts : 0
    let g:dont_load_subscripts = 1

    so $MYVIMRC

    let g:dont_load_subscripts = l:old
endfunc

func EditRC()
    execute 'normal! mB'
    nnoremap <leader><leader> :call GoBack()<cr>
    execute 'edit $MYVIMRC'
endfunc

func EditSrcFile()
    execute 'normal! mB'
    nnoremap <leader><leader> :call GoBack()<cr>
    execute 'edit' g:external_conf_scripts_dir
endfunc

func GoBack()
    write

    if expand('%:p') ==# $MYVIMRC
        " Nout sourcing the sources in the src folder is mainly done 
        " to avoid the error that comes with sourcing this function as
        " it's in use.
        call SourceVimrcWithoutScripts()
    elseif expand('%:p') ==# s:this_script_path
        " See immediately above
        echom "WARNING: scripts-utils.vim script should be sourced manually with \`so %\`"
    else
        so %
    endif

    nnoremap <leader><leader> :call EditRC()<cr>

    execute 'normal! `B'
endfunc

nnoremap <leader><leader> :call EditRC()<cr>
nnoremap <leader>s :call EditSrcFile()<cr>
nnoremap <localleader><localleader> :w<cr>:so %<cr>
