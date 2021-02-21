function! PerlHelloWorld()
perl << EOF
    VIM::Msg("Hello world!")
EOF
endfunction
