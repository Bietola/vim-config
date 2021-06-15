let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_root_markers = ['stack.yaml']

let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|stack-work)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
\ }
