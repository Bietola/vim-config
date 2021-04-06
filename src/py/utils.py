import vim

def errmsg(msg, fatal=False, exit_val=1):
    vim.command('echom "ERROR: ' + msg + '"')

    assert not fatal, msg

    return exit_val
