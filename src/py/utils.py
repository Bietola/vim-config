import vim
import re

term_buf_re = re.compile(r'^term:.*/bin/bash$')
def find_term_buffers():
    return filter(
        lambda b: term_buf_re.match(b.name),
        vim.buffers
    )
