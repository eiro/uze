export WORKON_HOME=~/local/virtualenvs/
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
path+=~/.local/bin/
nostrict source virtualenvwrapper.sh
alias workon='nostrict workon'
whence -am '*virtualenv*~_*' |%- {alias $1="nostrict $1"}
