let g:last_file_before_vim_src_edit = ''

function EditVimRC()
    let l:old_file = g:last_file_before_vim_src_edit

    if l:old_file ==# ''
        let l:old_file = expand('%:p')
        RCEdit
    else
        execute 'edit' l:old_file
        let l:old_file = ''
    endif
endfunction

function EditVimSrcFile()
    if l:old_file ==# ''
        execute 'normal! mO'
        execute 'edit' l:old_file
    else
        execute 'edit' l:old_file
        let l:old_file = ''
    endif
endfunction

function ResetLastFileBeforeVimSrcEdit()
    if &ft !=# 'vim' && &ft !=# 'netrw'
        g:last_file_before_vim_src_edit = ''
    endif
endfunction

nnoremap <leader><leader> :call EditVimRC()<cr>
nnoremap <leader>s :call EditVimSrcFile()<cr>

au BufEnter * call ResetLastFileBeforeVimSrcEdit()<cr>
