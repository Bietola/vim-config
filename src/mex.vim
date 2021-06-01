" Shitty script to emulate some excel action

" TODO: Make this work
" `~/bin/yexp` script required
" if !exists("~/bin/yexp")
"     echom "Error: ~/bin/yexp script required"
" endif

"""""""""
" Utils "
"""""""""

" Search and jump to first element
fun! RgJ(pattern)
    exe 'Rg' a:pattern
    if !empty(getqflist())
        normal [Q
    endif
endfun
command! -nargs=* RgJ call RgJ(<f-args>)

"""""""""""""""""""""""""""""""""""""""""""""""
" Interoperability w/ Mex Expression Language "
"""""""""""""""""""""""""""""""""""""""""""""""

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

"""""""""""""""""""
" Synchronization "
"""""""""""""""""""

" Git mappings
" TODO: Might have problems/ambiguities with symlinks
fun! GitQuickCommitAll(msg, do_amend = v:false)
    Git add -A
    if a:do_amend
        exe 'Git commit --amend --no-edit'
    else
        exe 'Git commit -m' a:msg
    endif
endfun

au filetype mex nnoremap <localleader>g1 :call GitQuickCommitAll('Initial')<cr>
au filetype mex nnoremap <localleader>g2 :call GitQuickCommitAll('Update')<cr>
au filetype mex nnoremap <localleader>g3 :call GitQuickCommitAll('Final')<cr>
au filetype mex nnoremap <localleader>ga :Git commit --amend --no-edit<cr>

"" rclone mappings

" slow

fun! MexRcloneSyncAll()
    !rclone sync --create-empty-src-dirs -P -L
        \ ~/sync/life/mex/ rem:main/life/mex/
endfun

au filetype mex nnoremap <localleader>rs :call MexRcloneSyncAll()<cr>

" fast

fun! MexRcloneSyncMain()
    !rclone sync --create-empty-src-dirs -P -L
        \ ~/sync/life/mex/main rem:main/life/mex/main
endfun

au filetype mex nnoremap <localleader>rf :call MexRcloneSyncMain()<cr>

" Quickly sync main folder everywhere with single mapping

fun! MexQuickSync(commit_msg, do_amend = v:false)
    call GitQuickCommitAll(a:commit_msg, a:do_amend)

    if a:do_amend
        G p -f
    else
        G p
    endif

    call MexRcloneSyncMain()
endfun

au filetype mex nnoremap <localleader>s1 :call MexQuickSync('Initial')<cr>
au filetype mex nnoremap <localleader>s2 :call MexQuickSync('Update')<cr>
au filetype mex nnoremap <localleader>s3 :call MexQuickSync('Final')<cr>
au filetype mex nnoremap <localleader>sa :call MexQuickSync('', v:true)<cr>
" TODO: Implement the mapping below using a vim prompt thingy life in
" vim-surround's `s**f`
" au filetype mex nnoremap <localleader>sm :call MexQuickSync('...')<cr>

""""""""""""""
" Todo Lists "
""""""""""""""

" Cross things out
fun! CycleCross(cross_box)
    if a:cross_box ==# '[X]'
        return '[ ]'
    elseif a:cross_box ==# '[ ]'
        return '[X]'
    else
        return '[ ]'
    endif
endfun
au filetype mex nnoremap <localleader>x :.s/\[.\{-}\]/\= CycleCross(submatch(0))/<cr>

"""""""""
" Lists "
"""""""""

" List any pattern
fun! MexListPatterns(pattern)
    exe 'RgJ' a:pattern
endfun
command! -nargs=1 MexListPatterns call MexListPatterns(<f-args>)
au filetype mex nnoremap <localleader>lp :MexListPatterns<space>

" List scheduled events
fun! MexListScheduledEvents()
    RgJ sched:
endfun
command! MexListScheduledEvents call MexListScheduledEvents()
au filetype mex nnoremap <localleader>ls :MexListScheduledEvents<cr>

" List headers
fun! MexListHeaders(pattern)
    exe 'RgJ' '\s*' . a:pattern . '.*:$'
endfun
command! -nargs=* MexListHeaders call MexListHeaders(<f-args>)
au filetype mex nnoremap <localleader>lh :MexListHeaders<space>
