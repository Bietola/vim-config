"""""""""""""""""""
" Synchronization "
"""""""""""""""""""

fun! OrgRcloneSyncPush()
    !rclone sync --create-empty-src-dirs -P -L
        \ ~/main/life/org/ db:main/life/org/
endfun

fun! OrgRcloneSyncFetch()
    !rclone sync -P -L
        \ db:main/life/org/ ~/main/life/org/
endfun

au filetype org nnoremap <localleader>sp :call OrgRcloneSyncPush()<cr>
au filetype org nnoremap <localleader>sf :call OrgRcloneSyncFetch()<cr>
