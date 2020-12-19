"" pathogen (RIP)
" execute pathogen#infect()
"" plug init (RIP)
"call plug#begin('~/.local/share/nvim/plugged')

" vimrc loading stuff
set exrc

" nvim :termin$al suff
if has("nvim")
  tnoremap <ESC><ESC> <C-\><C-n>
  "! tnoremap jk <C-\><C-n> " RIP (need caps lock for ranger)
endif

" window splitting shortcuuts
noremap <C-w>V <C-w>v<C-w><C-l>
noremap <C-w>S <C-w>s<C-w><C-j>
noremap <C-j> <C-w><C-j>
noremap <C-k> <C-w><C-k>
noremap <C-h> <C-w><C-h>
noremap <C-l> <C-w><C-l>

" window splitting options
set diffopt+=vertical

" file loading stuff
:set autowriteall

" operating system detection variables
if !exists("g:os")
if has("win64") || has("win32") || has("win16")
    let g:os = "Windows"
else
    let g:os = substitute(system('uname'), '\n', '', '')
endif
endif

" operating system make configuration
if g:os == "Windows"
set makeprg=mingw32-make
elseif g:os == "Linux"
set makeprg=make
endif

" operating system cmake configurations
if g:os == "Windows"
command -bar -nargs=1 CMake !cmake -G "MinGW Makefiles" <args>
elseif g:os == "Linux"
command -bar -nargs=1 CMake !cmake  <args>
end

" operating system cmake debug configurations
if g:os == "Windows"
command -bar -nargs=1 DMake !cmake -DCMAKE_BUILD_TYPE=Debug -G "MinGW Makefiles" <args>
elseif g:os == "Linux"
command -bar -nargs=1 DMake !cmake -DCMAKE_BUILD_TYPE=Debug <args>
end

" operating system cmake vcpkg configurations
if g:os == "Linux"
command -bar -nargs=1 VCMake !cmake -DCMAKE_TOOLCHAIN_FILE=/usr/pkg/vcpkg/scripts/buildsystems/vcpkg.cmake <args>
end

" autocomplete settings
set complete-=i
" suggested by mu complete
set completeopt+=menuone
set completeopt+=noselect
set shortmess+=c
set belloff+=ctrlg

" mucompolete-specific settings
let g:mucomplete#enable_auto_at_startup = 1

" ctrl settings
let g:ctrlp_show_hidden = 1

" leader
let mapleader = "ò"

" Sensible clipboard defaults
set clipboard=unnamedplus

" useful mappings
nnoremap <S-Enter> O<Esc>
nnoremap <CR> o<Esc>
" tabularize quick mapping
nnoremap <leader>tab :Tabularize 
vnoremap <leader>tab :Tabularize 
" sideways mappings
nnoremap <leader>h :SidewaysLeft<CR>
nnoremap <leader>l :SidewaysRight<CR>
" vimrc management
" TODO: Make a boxes related plugin
au filetype vim vnoremap <leader>b :'<,'>!boxes -d vim<cr>
au filetype vim nnoremap <leader>bb V:'<,'>!boxes -d vim<cr>
au filetype vim nnoremap <leader>bm vip:'<,'>!boxes -d vim -m<cr>

" terminal looks
set background=dark
set termguicolors
colorscheme iceberg
set guifont=Consolas:h17
nnoremap <leader>m :colorscheme morning<cr>

" tab (those akin to windows...) settings and custom commands
au TabEnter * if exists("t:wd") | exe "cd" t:wd | endif
let g:airline_powerline_fonts = 1

" whitespace (tab/backspace) things
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start

" fancy lines numbers
" turn hybrid line numbers on
" :set number relativenumber
" :set nu rnu
" turn hybrid line numbers off
" :set nonumber norelativenumber
" :set nonu nornu
" toggle hybrid line numbers
" :set number! relativenumber!
" :set nu! rnu!

" default syntax
syntax on
set syntax=cpp
filetype plugin indent on

" ctags and vim-tags settings
let g:vim_tags_auto_generate = 1
let g:vim_tags_directories = [".git/..", ".hg", ".svn", ".bzr", "_darcs", "CVS"]
let g:vim_tags_ignore_files = ['.gitignore', '.svnignore', '.cvsignore']
let g:vim_tags_project_tags_command = "{CTAGS} -R --fields=+l {OPTIONS} {DIRECTORY} 2>/dev/null"

" default path
set path+=../**

" menu options
set wildmenu
set number

" no idea... (should research)
set timeoutlen=10000

" utility remappings
" imap jk <Esc> " RIP (need caps lock for ranger)

" utility commands
command W      set wrap!
command NoWar  set errorformat^=%-G%f:%l:\ warning:%m
command Tgen   cd .. | !ctags -R | cd build
command Comp   !g++ main.cpp -o Proj
command RCEdit edit $MYVIMRC

command Ex  !./Proj
command Tex !/usr/bin/time ./Proj 

"" netrw settings
" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir='rm -r'
autocmd FileType netrw nnoremap ? :help netrw-quickmap<CR>

" TagBar settings
" TODO: nmap <leader><leader> :TagbarToggle<CR><c-w><c-w>

"" YCM things
" commands
command YCMToggleCompletionTrigger :let g:ycm_auto_trigger=!g:ycm_auto_trigger
" settings
let g:enable_ycm_at_startup = 0
let g:ycm_auto_trigger = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_collect_identifiers_from_tags_files = 1

""""""""""""""""""
" vsnip settings "
""""""""""""""""""
" All snippets are in this directory.
" TODO: Use `XDG_CONFIG_HOME` in path (set it in `/ect/profile`).
let g:vsnip_snippet_dir = "/home/dincio/.config/nvim/snippets"

" Keybindings.
"! imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<C-j>'
"! imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
"! smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <C-h>   vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <C-h>   vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" TODO: find out better way to do this
" NB. Ultisnips is not compatible with neovim... so we need to use the .vim
" directory
" set runtimepath^=~/.vim
" let g:UltiSnipsSnippetsDirectories=[$HOME.'/.vim/UltiSnips']

" Ultisnips
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"


" vim-slime options
let g:slime_target = "neovim"

" delimitMate options
let delimitMate_expand_cr = 1

" markdown mappings  
nnoremap <leader>ft :TableFormat<CR>

" surround mappings and custom settings
nmap s ys
au FileType lilypond let b:surround_45 = "<< \r >>"

" markdown settings  
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_enable_folding = 1

" vim-pandoc settings
"" let g:pandoc#syntax#codeblocks#embeds#langs = ["cpp"]
"let g:pandoc#folding#fold_fenced_codeblocks = 1

" gabrielelana markdown settings
" let g:markdown_enable_folding = 1

" mkdx configuration
" let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
"                         \ 'enter': { 'shift': 1 },
"                         \ 'links': { 'external': { 'enable': 1 } },
"                         \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
"                         \ 'fold': { 'enable': 1 } }
" let g:polyglot_disabled = ['markdown'] " for vim-polyglot users, it loads Plasticboy's markdown
"                                       " plugin which unfortunately interferes with mkdx list indentation.

"""""""""""""""""""""""""""""""""
" Local configuration directory "
"""""""""""""""""""""""""""""""""

let g:local_conf_dir = ".vim"

""""""""""""""""""""""""""""""""""""""
" Language specific setting sections "
""""""""""""""""""""""""""""""""""""""

" default formatting settings
set expandtab
set tabstop=4
set shiftwidth=4
set sts=4
set autoindent

" c and cpp formatting settings
au FileType cpp,c set expandtab
au FileType cpp,c set tabstop=4
au FileType cpp,c set shiftwidth=4
au FileType cpp,c set sts=4
au FileType cpp,c set autoindent

" MIPS formatting settings
au FileType asm set expandtab
au FileType asm set tabstop=8
au FileType asm set shiftwidth=8
au FileType asm set sts=8
au FileType asm set autoindent

" basic formatting settings
au FileType basic let b:delimitMate_quotes = "\""

" lisp formatting settings
au FileType lisp let b:delimitMate_quotes = "\""
au FileType lisp set expandtab
au FileType lisp set tabstop=2
au FileType lisp set shiftwidth=2

" haskell formatting settings
au FileType haskell set expandtab
au FileType haskell set tabstop=2
au FileType haskell set shiftwidth=2

" racket formatting settings
au FileType racket let b:delimitMate_quotes = "\""

"asdf formatting settings
au BufRead,BufNewFile *.asd set filetype=lisp

" python3 formatting settings
au FileType python set expandtab
au FileType python set tabstop=4
au FileType python set shiftwidth=4
au FileType python set sts=4
au FileType python set autoindent

"""""""""""""""""""""""""""""
" Haskell specific settings "
"""""""""""""""""""""""""""""

" Hindent
au filetype haskell let g:hindent_on_save = 0

" utility leader commands
nnoremap <leader>tt :tabnew<cr>:term<cr>
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>pwd :!pwd \| xclip -selection clipboard<cr>

" quick vimgrep command
command -nargs=1 Vimgrep vimgrep <args> ##
" NB: this initialization is customized for different languages
au filetype c,cpp nnoremap <leader>vi :args ./**<cr>
au filetype c,cpp nnoremap <leader>vg :Vimgrep 
au filetype c,cpp nnoremap <leader>v/ :Vimgrep ///g<cr>

" Lilypond general keybindings
" Compile current file
au filetype lilypond nnoremap <leader>c :w<cr>:!lilypond %<cr>
" View pdf associated with current file
au filetype lilypond nnoremap <leader>v :!zathura %:r.pdf &<cr>
" play selected notes
au filetype lilypond nnoremap <leader>p :set opfunc=LyPlay<CR>g@
" TODO: vmap <silent> <F4> :<C-U>call CountSpaces(visualmode(), 1)<CR>
" function to do heavy lifting
function! LyPlay(type)
    " Get notes specified by the motion
    if a:type == 'line'
        silent exe "normal! '[V']y"
    else
        silent exe "normal! `[v`]y"
    endif

    " Play them
    let lycommand = "!lyplay italiano do \"<->\""
    let lycommand = substitute(lycommand, "<->", @@, "")
    exe lycommand
endfunction

""""""""""""""""
" Nix settings "
""""""""""""""""

au filetype nix set foldmethod=indent

"""""""""""""""""
" Rust settings "
"""""""""""""""""
" Cargo
au filetype rust nnoremap <leader><leader>r :!cargo run<cr>
au filetype rust nnoremap <leader><leader>t :!cargo test<cr>
" Boxes
au filetype rust vnoremap <leader>b :'<,'>!boxes<cr>
au filetype rust nnoremap <leader>bb V:'<,'>!boxes<cr>
au filetype rust nnoremap <leader>bm vip:'<,'>!boxes -m<cr>
au filetype rust nnoremap <leader>vg :Vimgrep 
" Other useful keybindings
au filetype rust nnoremap <leader>vi :args src/**<cr>

"" C keybindings
au filetype c inoremap <c-c> <esc>:!gcc main.c<cr>i

"" Racket keybindings
" Slime
au filetype racket nnoremap <leader>tt :vsp<cr>:term racket<cr>:echo b:terminal_job_id<cr><c-w><c-l>
au filetype racket nnoremap <leader>fm :echo "WIP"<cr>

"" Haskell keybindings
" Slime
au filetype haskell nnoremap <leader>trw :vsp<cr>:term ghci<cr>:echo b:terminal_job_id<cr><c-w><c-l>
au filetype haskell nnoremap <leader>trt :tabnew<cr>:term ghci<cr>:echo b:terminal_job_id<cr>gT
" Comments
au filetype haskell vnoremap <leader>b :'<,'>!boxes -d ada-box<cr>
au filetype haskell vnoremap <leader>bm V:'<,'>!boxes -m<cr>
au filetype haskell nnoremap <leader>bb V:'<,'>!boxes -d ada-box<cr>
" Automatic formatting
au filetype haskell nnoremap <leader>fm :Hindent<cr>
" Tabular
au filetype haskell nnoremap <leader>t= :Tabular /=<cr>

" Git fugitive custom commands
command GA Git A

" Terminal stuff
tnoremap <Esc><Esc> <C-\><C-n>

" Scheme stuff
" Local leader.
autocmd FileType scheme let maplocalleader = "ò"
" TODO: try w/ localleader
nnoremap <leader>a mmggVG:SlimeSend<cr>'m

" Lance stuff
" NB. Lance is an educational language for the Formal Languages course at
" Polimi
autocmd FileType lance set syntax = lua

"" C#
let g:OmniSharp_server_use_mono = 1

""""""""""""""""""""""""""
" vim-wiki configuration "
""""""""""""""""""""""""""
set nocompatible
filetype plugin on
syntax on

""""""""""""""""""""""""""""""""""""""""""""
" External vimscript configuration scripts "
""""""""""""""""""""""""""""""""""""""""""""
let g:external_conf_scripts_dir = fnamemodify($MYVIMRC, ":h")."/src"

for src_file in split(glob(g:external_conf_scripts_dir."/*.vim"), "\n")
    exe "source" src_file
    echom "loaded " src_file
endfor
