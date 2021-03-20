function OpenRecentProj()
    browse oldfiles
    cd %:p:h
endfunction
command! OpenRecentProj call OpenRecentProj()

nnoremap <leader>op :OpenRecentProj<cr>
