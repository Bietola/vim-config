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
    echom 'running:' l:view_command
    echo system(l:view_command)
endfunction
command! ViewScore call ViewScore()

function GetOutputFileName()
    let l:cfile = readfile(expand('%'))
    for line in l:cfile
        let m = matchlist(line, '\v\\bookOutputName "(.*)"')
        if len(m)
            echom 'Output file name:' . m[1]
            return m[1]
        endif
    endfor

    echom 'Output file name:' . expand('%:r')
    return expand('%:r')
endfunction

function CompileScore()
    " Update output file name
    let s:score_file_name = GetOutputFileName()

    " Compile score
    let l:compile_command = join(['lilypond', expand('%')])
    echom 'running:' l:compile_command
    echo system(l:compile_command)
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

""""""""""""
" Settings "
""""""""""""

" Vim-surround
au filetype lilypond let b:surround_45 = "<< \r >>"

""""""""""""""""
" Autocommands "
""""""""""""""""

au filetype lilypond let s:score_file_name = GetOutputFileName()
