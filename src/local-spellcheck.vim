" A simple script to set up a local spelling environment within the current
" working directory.
"
" NB. Spellcheck is activated with `:set spell`.

" The g:local_conf_dir variable is where all workspace-dependent configuration
" is stored. If it is not already set, a default value is provided here.
if !exists("g:local_conf_dir")
  let g:local_conf_dir = ".vim"
endif

" This variable holds the path to the local custom spelling file relative
" to the current working directory.
let s:local_spell_dir = join([g:local_conf_dir, "/spell"], "")
let s:local_spell_file = join([s:local_spell_dir, "/custom.utf-8.add"], "") " TODO: Might add support for multiple languages

" Automatically load local spelling files if available
"
" NB. the `spellingfile` option needs to be set to a file which contains the **additional**
" words added to the dictionary (not all of them).
"
" NB. A `.vim` folder is created locally to store the spelling file.
if filereadable(s:local_spell_file)
  echom "Found local spellfile: " s:local_spell_file
  echom "Turning spellcheck on (deactivate with `set spell!`)"
  set spell
  let &spellfile = s:local_spell_file
endif

" Create a local spelling file
function MkLocalSpellfile()
  execute join(["!mkdir -p ", s:local_spell_dir], "")
  execute join(["!touch ", s:local_spell_file], "")
  let &spellfile = s:local_spell_file
endfunction
command MkLocalSpellfile call MkLocalSpellfile()
