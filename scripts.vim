" filetype already set; don't do these checks
if did_filetype()
    finish
endif
if getline(1) =~ '^#!/usr/bin/env stack.*'
    setfiletype haskell
endif
