export HISTSIZE=25000

if [ -f ~/.bash_local_config ]; then
    source ~/.bash_local_config
fi

if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

source ~/.git-prompt.sh
source ~/.npm-completion.sh
source ~/.python_env

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export VIRTUAL_ENV_DISABLE_PROMPT=1
export TERM=screen-256color

# Alias

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias xo='xdg-open'

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -lah'
alias l='ls -CF'
alias ..='cd ..'

shopt -s histappend
shopt -s checkwinsize

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# Colors

RESTORE='[0m'
RED='[00;31m'
RED1='[38;5;197m'
GREEN='[00;32m'
GREEN1='[38;5;112m'
YELLOW='[00;33m'
BLUE='[00;34m'
BLUE1='[38;5;33m'
ORANGE='[38;5;208m'
PURPLE='[00;35m'
CYAN='[00;36m'
CYAN1='[38;5;080m'
LIGHTGRAY='[00;37m'
LRED='[01;31m'
LGREEN='[01;32m'
LYELLOW='[01;33m'
LBLUE='[01;34m'
LPURPLE='[01;35m'
LCYAN='[01;36m'
WHITE='[01;37m'

reset_ps1() {
    PS1='┌['
    PS1+='\[\e${CYAN1}\]'
    PS1+='\u' # User
    PS1+='\[\e${LCYAN}\]'
    PS1+='@'
    PS1+='\[\e${RESTORE}\]'
    PS1+='\[\e${CYAN1}\]'
    PS1+='\h' # Host
    PS1+='\[\e${RESTORE}\]'
    PS1+=']-['
    PS1+='\[\e${ORANGE}\]'
    PS1+='\w' # Path
    PS1+='\[\e${RESTORE}\]'
    PS1+=']'

    if command -v nvm &> /dev/null; then
        nvm_env=$(nvm current)
        PS1+='-[\[\e${YELLOW}\]nvm:${nvm_env##*/}\e\[${RESTORE}\]]' # Node Virtual Manager
    fi

    if command -v conda &> /dev/null; then
        export VIRTUAL_ENV="conda:"$CONDA_DEFAULT_ENV
    fi

    if [[ -v VIRTUAL_ENV ]]; then
        PS1+='-[\[\e${BLUE1}\]${VIRTUAL_ENV##*/}\e\[${RESTORE}\]]' # Python Virtual Env
    fi

    PS1+='$(__git_ps1 "-[\[\e${RED1}\]%s\e\[${RESTORE}\]]")' # Git
    PS1+='\n└['
    PS1+='\[\e${GREEN1}\]'
    PS1+='\$'
    PS1+='\[\e${RESTORE}\]'
    PS1+='] '
}

conda_env() {
    name=$1
    conda activate $name
    echo "conda activate "$name > ~/.python_env
    reset_ps1
}

venv_env() {
    name=$1
    echo "source ~/pythonenv/"$name"/bin/activate" > ~/.python_env
    source ~/.python_env
    reset_ps1
}

venv_env_create() {
    name=$1
    eval "python -m venv ~/pythonenv/"$name
    venv_env $name
}

nvm_env() {
    name=$1
    nvm use $name
    reset_ps1
}

alias plist='ls ~/pythonenv'
alias penv='venv_env'
alias penv_create='venv_env_create'
alias cenv='conda_env'
alias nenv='nvm_env'

reset_ps1
