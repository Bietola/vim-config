## Create python3 virtual env

1. `python --version` needs to be 3.*
2. Go inside venv folder
3. `python -m venv .`
3. `source ./bin/activate`
4. `python -m pip install --upgrade pip`
5. `python -m pip install pynvim`
6. `deactivate`

## Create python2 virtual env

1. `python2 --version` needs to be 2.*
2. Go inside venv folder
3. `virtualenv -p "$(which python2)"`
3. `source ./bin/activate`
4. `python2 -m pip install --upgrade pip`
5. `python2 -m pip install pynvim`
6. `deactivate`
