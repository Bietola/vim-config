" Current pdf file to open when viewing score
let s:score_file_name = ''

"""""""""""""
" Functions "
"""""""""""""

function GetScoreFileName()
    if s:score_file_name != ''
        return s:score_file_name
    else
        return expand('%:r') . '.pdf'
    endif
endfunction

function ViewScore()
    let l:view_command = 'zathura '. GetScoreFileName() . '.pdf' . ' &'
    echom l:view_command
    call system(l:view_command)
endfunction
command! ViewScore call ViewScore()

function CompileScore()
    " Update output file name
    let l:cfile = readfile(expand('%'))
    for line in l:cfile
        let m = matchlist(line, '\v\\bookOutputName "(.*)"')
        if len(m)
            let s:score_file_name = m[1]
            echom 'Changed score_file_name to ' . s:score_file_name
        endif
        " TODO/CICCIO
    endfor

    " Compile score
    let l:compile_command = join(['lilypond', expand('%')])
    echom l:compile_command
    call system(l:compile_command)
endfunction
command! CompileScore call CompileScore()

"""""""""""""""
" Keybindings "
"""""""""""""""

" Local leader
au filetype lilypond let maplocalleader = "ò"

" Compile current file
" TODO/BU au filetype lilypond nnoremap <localleader>c :w<cr>:!lilypond %<cr>
au filetype lilypond nnoremap <localleader>c :CompileScore<cr>

" View pdf associated with current file
au filetype lilypond nnoremap <localleader>v :ViewScore<cr>

" Play all file with midi
au filetype lilypond nnoremap <localleader>pa :!lyplay %:r.midi<cr>

" Play only from specified bar
au filetype lilypond nnoremap <localleader>pb :!lyplay %:r.midi<space>

" Vim-surround settings
nmap s ys
au FileType lilypond let b:surround_45 = "<< \r >>"
