# Instructions to update pynvim version

If `:checkhealth` inside **neovim** prompts that "WARNING: Latest pynvim is NOT installed: ...", then follow these instructions:

1. Go inside `../nvim-pyX-venv` (or py2).
2. Activate the venv with `source ./bin/activate`.
3. Update pip with `pythonX -m pip install pip -U`.
4. Update pynvim with `pythonX -m pip install pynvim -U`.
5. Deactivate venv with `deactivate`.
6. Profit.
