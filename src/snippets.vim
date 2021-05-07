" Ultisnips
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

nnoremap <leader>es :UltiSnipsEdit<cr>

" Talon ultisnips integration
nnoremap <leader>st :e ~/.talon/user/ultisnips/ultisnips.py<cr>
nnoremap <leader>sut :e ~/.talon/user/ultisnips/ultisnips.py<cr>:w<cr><c-^> " Just update talon snippets file
