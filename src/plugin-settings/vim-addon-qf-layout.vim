" NB. This doesn't... but is from the official docs on github
" " This declares the defaults, so just add the keys to .vimrc you want to change
" let g:vim_addon_qf_layout = {}
" let g:vim_addon_qf_layout.quickfix_formatters = [ 'NOP', 'vim_addon_qf_layout#DefaultFormatter', 'vim_addon_qf_layout#FormatterNoFilename', 'vim_addon_qf_layout#Reset' ]
" let g:vim_addon_qf_layout.lhs_cycle = '<buffer> \v'
" let g:vim_addon_qf_layout.file_name_align_max_width = 60

" " Optionally you can define your own mappings like this:
" " noremap \no_filenames call vim_addon_qf_layout#ReformatWith('vim_addon_qf_layout#FormatterNoFilename')<cr>

" NB. This makes formatting work
let g:vim_addon_qf_layout = {}
let g:vim_addon_qf_layout.quickfix_formatters = [
    \'vim_addon_qf_layout#DefaultFormatter',
    \'vim_addon_qf_layout#FormatterNoFilename',
    \'vim_addon_qf_layout#Reset',
    \'NOP' ]
