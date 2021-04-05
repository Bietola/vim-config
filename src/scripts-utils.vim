let s:this_script_path = expand('<sfile>:p')

au filetype vim let maplocalleader = 'ò'

func s:SourceVimrcWithoutScripts()
    let l:old = exists('g:dont_load_subscripts') ? g:dont_load_subscripts : 0
    let g:dont_load_subscripts = 1

    so $MYVIMRC

    let g:dont_load_subscripts = l:old
endfunc

func s:SavePosition()
    if expand('%:p') !=# $MYVIMRC && expand('%:p:h') != g:external_conf_scripts_dir
        execute 'normal! mB'
    endif
endfunc

func EditRC()
    call s:SavePosition()
    nnoremap <leader><leader> :call GoBack()<cr>
    execute 'edit $MYVIMRC'
endfunc

func EditSrcFile()
    call s:SavePosition()
    nnoremap <leader><leader> :call GoBack()<cr>
    execute 'edit' g:external_conf_scripts_dir
endfunc

func GoBack()
    if &readonly == 'noreadonly'
        write

        if expand('%') ==# ''
            " Here to avoid errors due to expansions of empty % not working
            echom "WARNING: coming back from empty filename (SHOULD NOT BE POSSIBLE)"
        elseif expand('%:p') ==# $MYVIMRC
            " Nout sourcing the sources in the src folder is mainly done 
            " to avoid the error that comes with sourcing this function as
            " it's in use.
            call s:SourceVimrcWithoutScripts()
        elseif expand('%:p') ==# s:this_script_path
            " See immediately above
            echom "WARNING: scripts-utils.vim script should be sourced manually with \`so %\`"
        else
            so %
        endif
    endif

    nnoremap <leader><leader> :call EditRC()<cr>

    execute 'normal! `B'
endfunc

nnoremap <leader><leader> :call EditRC()<cr>
nnoremap <leader>s :call EditSrcFile()<cr>

nnoremap <localleader>s :w<cr>:so %<cr>
