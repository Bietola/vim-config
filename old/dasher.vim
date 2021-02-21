"""""""""""
" Keymaps "
"""""""""""
"
" NB. Dasher only works best with ascii characters, so all mappings below have
" the purpose of making vim normal mode more digestible for dasher.

inoremap jk <esc>
nnoremap r <C-R>
nnoremap td }
nnoremap tu {

" Insert mode keycodes
inoremap <lt>!cr!> <cr>
inoremap <lt>!bs!> <bs>

"""""""""""""""""""""""""""
" Special backspace undos "
"""""""""""""""""""""""""""

" Dasher sends a backspace when an operation is undone; this sections is
" dedicated to interpret backspace in special ways that undo vim operations
" seamlessly.
nnoremap <bs> :call HandleBackspaceAsUndo()<cr>
inoremap <bs> <esc>:call HandleBackspaceAsUndo()<cr>
vnoremap <bs> <esc>:echom 'WIP'<cr>

" Starting undo state
let s:undo_mode = 'normal'

" Keys for which a special undo state is needed
nnoremap <silent> j :call HandleSpecialUndoKey('j')<cr>j
nnoremap <silent> k :call HandleSpecialUndoKey('k')<cr>k
nnoremap <silent> h :call HandleSpecialUndoKey('h')<cr>h
nnoremap <silent> l :call HandleSpecialUndoKey('l')<cr>l
nnoremap o :call HandleSpecialUndoKey('o')<cr>o
nnoremap i :call HandleSpecialUndoKey('i')<cr>i
nnoremap p :call HandleSpecialUndoKey('p')<cr>p

"TODO: Mappings to be handled (nooped for now)
nnoremap <lt> <nop>
nnoremap > <nop>
nnoremap ! <nop>

" Prepared undo state in case of undo
function HandleSpecialUndoKey(key)
    " TODO: To be used for f-like keys later
    " TODO: Learn to use sets
    " if a:key == '|'
    "     s:undo_pos = { 'line': line('.'), 'col': col('.') }
    " endif

    let s:undo_mode = a:key
    let s:undo_flag = 1
endfunction

" Handle special undo (heavylifting)
function HandleBackspaceAsUndo()
    " NB. Use `help expr-quote` to review special characters in strings (like
    "     `\b` and `\e` used below)
    
    let l:UNDO_MSG = 'Executing directional undo'

    if s:undo_mode == 'normal'
        echom 'Executing undo as noop'

    elseif s:undo_mode == 'o'
        echom 'Executing o-type undo'
        let s:undo_mode = 'normal'
        normal! ddk

    elseif s:undo_mode == 'i'
        echom 'Executing i-type undo'
        let s:undo_mode = 'normal'
        execute 'normal! \e'

    elseif s:undo_mode == 'p'
        echom 'Executing p-type undo'
        let s:undo_mode = 'normal'
        execute 'normal! u'

    " TODO: To be used for find later
    " elseif s:undo_mode == '|'
    "     echom 'Executing pipe undo'
    "     cursor(s:undo_pos.line, s:undo_pos.col)

    " TODO: Clean using `opposite_dir` function
    " TODO: Handle beggining/end-of-the-line/file edge cases
    elseif s:undo_mode == 'j'
        echom l:UNDO_MSG
        let s:undo_mode = 'normal'
        normal! k
    elseif s:undo_mode == 'k'
        echom l:UNDO_MSG
        let s:undo_mode = 'normal'
        normal! j
    elseif s:undo_mode == 'h'
        echom l:UNDO_MSG
        let s:undo_mode = 'normal'
        normal! l
    elseif s:undo_mode == 'l'
        echom l:UNDO_MSG
        let s:undo_mode = 'normal'
        normal! h

    else
        echom 'ERROR: Unknown special undo state: ' + s:undo_mode
        let s:undo_mode = 'normal'
    endif
    "TODO: Add in later: execute 'normal! ddk'
endfunction
