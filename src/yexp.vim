" Shitty script to emulate some excel action

" TODO: Make this work
" `~/bin/yexp` script required
" if !exists("~/bin/yexp")
"     echom "Error: ~/bin/yexp script required"
" endif

" Local leader for plan files
" TODO: Find out why this doesn't work
au BufRead,BufNewfile *.pln let maplocalleader = "à"

" Process file with yexp
function YexpStep()
  normal mm
  execute join(["%!~/bin/yexp 2>", expand("%:p:h"), "/yexp-err"], "")
  normal 'mf>w
  normal zz
endfunction
command! YexpStep call YexpStep()

" Change control character
function YexpSetCC(cc)
  execute join([".!awk 'match($0, /^(.*):.>(.*)/, m) { print m[1] \":", a:cc, ">\" m[2] }'"], "")
endfunction

" Mappings
" TODO: Make <localleader> work here
nnoremap àu :call YexpStep()<cr>
nnoremap àce :call YexpSetCC('E')<cr>f>w
nnoremap àcc :call YexpSetCC('E')<cr>f>w:YexpStep<cr>
nnoremap àcv :call YexpSetCC('$')<cr>f>w
nnoremap àcs :call YexpSetCC('S')<cr>f>w
