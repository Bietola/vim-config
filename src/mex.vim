" Shitty script to emulate some excel action

" TODO: Make this work
" `~/bin/yexp` script required
" if !exists("~/bin/yexp")
"     echom "Error: ~/bin/yexp script required"
" endif

" Local leader for plan files
" TODO: Find out why this doesn't work
au BufRead,BufNewfile *.pln let maplocalleader = "à"

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

" Mappings
" TODO: Make <localleader> work here
nnoremap àu :call MexStep()<cr>
nnoremap àce :call MexSetCC('E')<cr>f>w
nnoremap àcc :call MexSetCC('E')<cr>f>w:MexStep<cr>
nnoremap àcv :call MexSetCC('$')<cr>f>w
nnoremap àcs :call MexSetCC('S')<cr>f>w
