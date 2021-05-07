" Use neovim's own terminal instead of tmux
let g:tidal_target = "terminal"

func! TidalSetup()
    set filetype=haskell
    let b:coc_enabled = 0
endfunc

" Set .tidal files to be haskell files
autocmd BufNewFile,BufRead *.tidal :call TidalSetup()
