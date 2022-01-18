"" Useful keybindings
" Send line
nnoremap <c-c><c-d> :SlimeSendCurrentLine<cr>

" APL Repl
" TODO: Generalize this
au filetype apl nnoremap <localleader>rv :vsp<cr>:term dyalog<cr>:echo b:terminal_job_id<cr><c-w><c-L><c-w><c-w>
au filetype apl nnoremap <localleader>rt :tabnew<cr>:term dyalog<cr>:echo b:terminal_job_id<cr>gT
