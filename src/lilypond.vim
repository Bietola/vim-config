"""""""""""""
" Functions "
"""""""""""""

function GetScoreFileName()
    if s:score_file_name != ''
        return s:score_file_name . '.pdf'
    else
        return expand('%:r') . '.pdf'
    endif
endfunction

function GetMidiFileName()
    if s:score_file_name != ''
        return s:score_file_name . '.midi'
    else
        return expand('%:r') . '.midi'
    endif
endfunction

function ViewScore()
    let l:view_command = 'zathura '. GetScoreFileName() . ' &'
    echom 'running:' l:view_command
    echo system(l:view_command)
endfunction
command! ViewScore call ViewScore()

function PlayMidiFromBar(start_bar)
    let l:play_shell_command = 'lyplay '. GetMidiFileName() . ' ' . a:start_bar
    echom 'running:' l:play_shell_command
    execute '!' . l:play_shell_command
endfunction
command! -nargs=1 PlayMidiFromBar call PlayMidiFromBar(<args>)

function PlayMidiAll()
    call PlayMidiFromBar(1)
endfunction
command! PlayMidiAll call PlayMidiAll()

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
    exe 'cd' expand('%:p:h')
    let l:compile_command = join(['lilypond', expand('%:p')])
    echom 'running:' l:compile_command
    echo system(l:compile_command)
    cd -
endfunction
command! CompileScore call CompileScore()

function PlayNote(alda_note)
    " TODO/WIP
    let l:play_command = 'alda play -c "piano: ' . a:alda_note . '"'
    echom 'running:' l:play_command
    silent exec '!' . l:play_command
endfunction

function CreateNoteBindings()
    for note in ['a', 'b', 'c', 'd', 'e', 'f', 'g']
        for acc in ['+', '-', '']
            if acc == ''
                let bind_lead = 'n'
            else
                let bind_lead = acc
            endif

            execute 'nnoremap <localleader>' . bind_lead . note . ' :call PlayNote("' . note . acc . '")<cr>'
        endfor
    endfor
endfunction

function StartAldaServer()
    echom system('alda up')
endfunction
command! StartAldaServer call StartAldaServer()

"""""""""""""""
" Keybindings "
"""""""""""""""

" Local leader
au filetype lilypond let maplocalleader = "ò"

" Compile current file
au filetype lilypond nnoremap <localleader>c :w<cr>:CompileScore<cr>

" View pdf associated with current file
au filetype lilypond nnoremap <localleader>v :ViewScore<cr>

" Play all file with midi
" TODO/BU au filetype lilypond nnoremap <localleader>pa :!lyplay %:r.midi<cr>
au filetype lilypond nnoremap <localleader>a :PlayMidiAll<cr>

" Play only from specified bar
au filetype lilypond nnoremap <localleader>b :PlayMidiFromBar<space>

" Play specified musical note
au filetype lilypond call CreateNoteBindings()

" Start **alda** server
au filetype lilypond nnoremap <localleader>A :StartAldaServer<cr>

""""""""""""
" Settings "
""""""""""""

" Vim-surround
au filetype lilypond let b:surround_45 = "<< \r >>"

""""""""""""""""
" Autocommands "
""""""""""""""""

au filetype lilypond let s:score_file_name = GetOutputFileName()
