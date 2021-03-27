function OpenRecentProj()
    browse oldfiles
    
    echom expand('%:p')

    if isdirectory(expand('%:p'))
        cd %:p
    else
        cd %:p:h
    endif
endfunction
command! OpenRecentProj call OpenRecentProj()

nnoremap <leader>op :OpenRecentProj<cr>
