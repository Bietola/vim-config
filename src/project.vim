""""""""""""""""""""""""""""""""""""""""
" Useful things for project management "
""""""""""""""""""""""""""""""""""""""""

" Put all files tracked by git to args list
" NB. Replaces old args list
command! ArgsFromGit exe 'args' join(systemlist('git ls-files'), ' ')
" Mnemonic: vim args
" NB. `<leader>vg` (vim grep) is usually only useful after using this
nnoremap <leader>va :ArgsFromGit<cr>

" Open a recent project
fun! OpenRecentProj()
    browse oldfiles
    
    echom expand('%:p')

    if isdirectory(expand('%:p'))
        cd %:p
    else
        cd %:p:h
    endif
endfun
command! OpenRecentProj call OpenRecentProj()
nnoremap <leader>op :OpenRecentProj<cr>

" Go to last thing to do
command! GotoTODOCC Vimgrep TODO\/CC
" Mnemonic: goto cicciocacca
nnoremap <leader>gc :GotoTODOCC<cr>
