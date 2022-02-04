let s:current_colorscheme  = 'iceberg'

function! GetColorScheme()
    redir @a
    sil exe 'colorscheme'
    redir END
    return trim(@a)
endfunction

function! ToggleBG()
    if &background ==# 'dark'
        set background=light
    else
        set background=dark
    endif
endfunction

nnoremap <leader>c :call ToggleBG()<cr>
