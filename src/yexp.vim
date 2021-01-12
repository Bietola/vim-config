" Shitty script to emulate some excel action

" TODO: Make this work
" `~/bin/yexp` script required
" if !exists("~/bin/yexp")
"     echom "Error: ~/bin/yexp script required"
" endif

" Process file with yexp
function YexpStep()
  normal mm
  execute join(["%!~/bin/yexp 2>", expand("%:p:h"), "/yexp-err"], "")
  normal 'mf>w
endfunction
command! YexpStep call YexpStep()

" Change control character
function YexpSetCC(cc)
  execute join([".!awk 'match($0, /^(.*):.>(.*)/, m) { print m[1] \":", a:cc, ">\" m[2] }'"], "")
endfunction

" Mappings
nnoremap <leader>u :call YexpStep()<cr>
nnoremap <leader>ce :call YexpSetCC('E')<cr>f>w:call YexpStep()<cr>
nnoremap <leader>cv :call YexpSetCC('$')<cr>f>w
nnoremap <leader>cs :call YexpSetCC('S')<cr>f>w
