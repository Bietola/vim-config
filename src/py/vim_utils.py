import vim
import re

sys.path.append('/config/dotfiles/nvim/src/py/')
from . import utils

_term_buf_re = re.compile(r'^term:.*/bin/bash$')
def find_term_buffers():
    return filter(
        lambda b: _term_buf_re.match(b.name),
        vim.buffers
    )

def find_next_term_buf():
    next_b = next(find_term_buffers(), None)
    if next_b != None:
        return next_b
    else:
        # TODO: Find more elegant way to create new buffer without switching to it
        user_buffer = vim.current.buffer
        vim.command('enew')
        vim.command('term')
        vim.current.buffer = user_buffer

        next_b = next(find_term_buffers(), None)
        if next_b == None:
            errmsg("Can't find freshly created term buffer!", fatal=True)
        else:
            return next_b
