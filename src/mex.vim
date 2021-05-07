" Shitty script to emulate some excel action

" TODO: Make this work
" `~/bin/yexp` script required
" if !exists("~/bin/yexp")
"     echom "Error: ~/bin/yexp script required"
" endif

" Process file with mex
function MexStep()
  normal mm
  execute join(["%!mex 2>", expand("%:p:h"), "/mex-err"], "")
  normal 'mf>w
  normal zz
endfunction
command! MexStep call MexStep()

" Change control character
function MexSetCC(cc)
  execute join([".!awk 'match($0, /^(.*):.>(.*)/, m) { print m[1] \":", a:cc, ">\" m[2] }'"], "")
endfunction

" Set .mex files to be mex files
au BufNewFile,BufRead *.mex :set filetype=mex

" Indentation
au filetype mex set foldmethod=indent

" Local leader
au filetype mex let maplocalleader = 'ò'

" Mappings
" TODO: Make <localleader> work here
au filetype mex nnoremap <localleader>u :call MexStep()<cr>
au filetype mex nnoremap <localleader>ce :call MexSetCC('E')<cr>f>w
au filetype mex nnoremap <localleader>cE :%s/:.*>/:E>/g<cr>:nohlsearch<cr>
au filetype mex nnoremap <localleader>cc :call MexSetCC('E')<cr>f>w:MexStep<cr>
au filetype mex nnoremap <localleader>cC :%s/:.*>/:E>/g<cr>:nohlsearch<cr>:MexStep<cr>
au filetype mex nnoremap <localleader>cv :call MexSetCC('$')<cr>f>w
au filetype mex nnoremap <localleader>cs :call MexSetCC('S')<cr>f>w

" Tabular mappings
func! TabularizeMexSchedule()
    " TODO: Make this ignore the first header line with a colon at the end.
    " TODO: This doesn't seem to work:
    " Tabularize /^.*\zs:\n\@!/l1c1l0
    "                    ^^^^^

    " Last colon (first is for timestamps)
    Tabularize /^.*\zs:/l1c1l0

    " First comma (why first? no reason...)
    Tabularize /^[^,]*\zs,/l1c1l0
endfunc

" TODO: Make this ignore the first header line with a colon at the end...
au filetype mex nnoremap <localleader>t :call TabularizeMexSchedule()<cr>

" Git mappings
au filetype mex nnoremap <localleader>g1 :cd %:p:h<cr>:!git add -A<cr>:Git commit -m "Initial"<cr>
au filetype mex nnoremap <localleader>g2 :cd %:p:h<cr>:!git add -A<cr>:Git commit -m "Update"<cr>
au filetype mex nnoremap <localleader>g3 :cd %:p:h<cr>:!git add -A<cr>:Git commit -m "Final"<cr>
au filetype mex nnoremap <localleader>ga :cd %:p:h<cr>:!git commit --amend --no-edit<cr>
