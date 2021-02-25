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

" Local leader
au filetype mex let maplocalleader = 'ò'

" Mappings
" TODO: Make <localleader> work here
au filetype mex nnoremap <localleader>u :call MexStep()<cr>
au filetype mex nnoremap <localleader>ce :call MexSetCC('E')<cr>f>w
au filetype mex nnoremap <localleader>cc :call MexSetCC('E')<cr>f>w:MexStep<cr>
au filetype mex nnoremap <localleader>cv :call MexSetCC('$')<cr>f>w
au filetype mex nnoremap <localleader>cs :call MexSetCC('S')<cr>f>w
