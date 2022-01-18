"" pathogen (RIP)
" execute pathogen#infect()

" plug init
call plug#begin('~/.local/share/nvim/plugged')

" plugins
" TODO: Doesn't work during PlugUpdate Plug 'davidgranstrom/scnvim', { 'do': {-> scnvim#install() } }
Plug 'PyGamer0/vim-apl'
Plug 'MarcWeber/vim-addon-qf-layout'
Plug 'jremmen/vim-ripgrep'
Plug 'tidalcycles/vim-tidal'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sersorrel/vim-lilypond'
Plug 'vimwiki/vimwiki'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'daveyarwood/vim-alda'
Plug 'calincru/flex-bison-syntax'
Plug 'ron-rs/ron.vim'
Plug 'sirver/UltiSnips'
Plug 'alx741/vim-hindent'
Plug 'AndrewRadev/dsf.vim'
Plug 'runoshun/vim-alloy'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'rust-lang/rust.vim'
Plug 'tommcdo/vim-exchange'
Plug 'gyim/vim-boxdraw'
" Plug 'kana/vim-tabpagecd'
Plug 'Raimondi/delimitMate'
Plug 'szw/vim-tags'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'jpalardy/vim-slime'
Plug 'AndrewRadev/sideways.vim'
" Plug 'Valloric/YouCompleteMe' (RIP)
Plug 'majutsushi/tagbar'
Plug 'thaerkh/vim-workspace'
Plug 'godlygeek/tabular'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/ctrlp.vim'

" programming languages
Plug 'OmniSharp/omnisharp-vim'
Plug 'vim-perl/vim-perl6'
Plug 'quabug/vim-gdscript'
Plug 'sheerun/vim-polyglot'
"TODO Plug 'vim-syntastic/syntastic'

" colorschemes
Plug 'JarrodCTaylor/spartan'
Plug 'KKPMW/sacredforest-vim'
Plug 'cocopon/iceberg.vim'

" plug deinit
call plug#end()

" vimrc loading stuff
set exrc

" nvim :termin$al suff
if has("nvim")
  tnoremap <ESC><ESC> <C-\><C-n>
  "! tnoremap jk <C-\><C-n> " RIP (need caps lock for ranger)
endif

" Better navigation with relative line numbers
set relativenumber

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

" leaders
let mapleader = "à"
let maplocalleader = "ò"

" useful mappings
nnoremap <S-Enter> O<Esc>
nnoremap <CR> o<Esc>
" tabularize quick mapping
nnoremap <leader>tab :Tabularize 
vnoremap <leader>tab :Tabularize 
" sideways mappings
nnoremap <leader>H :SidewaysLeft<CR>
nnoremap <leader>L :SidewaysRight<CR>

" terminal looks
set background=dark
set termguicolors
colorscheme iceberg
set guifont=Consolas:h17
nnoremap <leader>m :colorscheme morning<cr>

" Airline settings
let g:airline_powerline_fonts = 2

" whitespace (tab/backspace) things
set tabstop=4
set shiftwidth=4
set expandtab
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

" quick way to exit vim
nnoremap zq :wq<cr>

" default path
set path+=../**

" Some quality of life options
set wildmenu
set number
let g:netrw_keepdir=0

" no idea... (should research)
set timeoutlen=10000

" utility remappings
" imap jk <Esc> " RIP (need caps lock for ranger)

" utility commands
command! LineWrap set wrap!
command! NoWar    set errorformat^=%-G%f:%l:\ warning:%m
command! Tgen     cd .. | !ctags -R | cd build
command! Comp     !g++ main.cpp -o Proj
command! RCEdit   edit $MYVIMRC
nnoremap <leader><leader> :RC<cr>

command Ex  !./Proj
command Tex !/usr/bin/time ./Proj 

"" netrw settings
" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir='rm -r'
autocmd FileType netrw nnoremap ? :help netrw-quickmap<CR>
autocmd FileType netrw nnoremap <localleader>r :Ranger<cr>

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
" TODO: find out better way to do this
" NB. Ultisnips is not compatible with neovim... so we need to use the .vim
" directory
" set runtimepath^=~/.vim
" let g:UltiSnipsSnippetsDirectories=[$HOME.'/.vim/UltiSnips']

" vim-slime options
let g:slime_target = "neovim"

" delimitMate options
let delimitMate_expand_cr = 1

" markdown mappings  
nnoremap <leader>ft :TableFormat<CR>

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

"""""""""""""""""
" Vim providers "
"""""""""""""""""

let g:python_host_prog  = "~/.config/nvim/providers/py/nvim-py2-venv/bin/python"
let g:python3_host_prog  = "~/.config/nvim/providers/py/nvim-py3-venv/bin/python"

""""""""""""""""""""""""""""
" Python specific settings "
""""""""""""""""""""""""""""

" python formatting settings
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
nnoremap gu {
nnoremap gd }
command Clipwd !pwd \| xclip -selection clipboard<cr>

" quick vimgrep command
command -nargs=1 Vimgrep vimgrep <args> ##
nnoremap <leader>vg :Vimgrep 
" NB: initialization for vimgrep to work properly is handled differently by different languages

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
" Other useful keybindings
au filetype rust nnoremap <leader>vi :args src/**<cr>

"" C/C++ keybindings
au filetype c,cpp nnoremap <leader>vi :args ./**<cr>
au filetype c,cpp nnoremap <leader>v/ :Vimgrep ///g<cr>

"" C only keybindings
au filetype c inoremap <c-c> <esc>:!gcc main.c<cr>i

"" Racket keybindings
" Slime
au filetype racket nnoremap <leader>tt :vsp<cr>:term racket<cr>:echo b:terminal_job_id<cr><c-w><c-l>
au filetype racket nnoremap <leader>fm :echo "WIP"<cr>

"" Haskell keybindings
" Slime
au filetype haskell nnoremap <leader>trw :vsp<cr>:term ghci<cr>:echo b:terminal_job_id<cr><c-w><c-l>
au filetype haskell nnoremap <leader>trt :tabnew<cr>:term ghci<cr>:echo b:terminal_job_id<cr>gT
" Automatic formatting
au filetype haskell nnoremap <leader>fm :Hindent<cr>
" Tabular
au filetype haskell nnoremap <leader>t= :Tabular /=<cr>

" Git fugitive custom commands
command GA Git A

" Terminal stuff
tnoremap <Esc><Esc> <C-\><C-n>

" Scheme stuff
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

" Enter script directory so that relative script imports work
let s:vim_execution_path = expand('%:p:h')
exe 'cd' g:external_conf_scripts_dir

" Setup python `sys.path` properly so that relative python imports in `py`
" folder work
" TODO
py3 sys.path.append(vim.eval('g:external_conf_scripts_dir'))

" Load subscripts
if exists('g:dont_load_subscripts') == 0 || g:dont_load_subscripts == 0
    for src_file in split(glob(g:external_conf_scripts_dir."/**/*.vim"), "\n")
        exe "source" src_file
        " echom "loaded " src_file
    endfor
endif

" Return to folder from which vim was called
exe 'cd' s:vim_execution_path
