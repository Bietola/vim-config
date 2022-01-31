"" Useful keybindings
" Send line
nnoremap <c-c><c-l> :SlimeSendCurrentLine<cr>

fun OpenRepl()
    let l:term_win = win_getid()
    wincmd v
    let l:last_win = win_getid()
    call win_gotoid(l:term_win)
    term dyalog
    echo b:terminal_job_id
    call win_gotoid(l:last_win)
endfun

" APL Repl
" TODO: Generalize this
au filetype apl nnoremap <localleader>rv :call OpenRepl()<cr>
au filetype apl nnoremap <localleader>rt :tabnew<cr>:term dyalog<cr>:echo b:terminal_job_id<cr>gT
