
# Enable vim mode in bash
# set -o vi
export EDITOR=vim
export VISUAL=vim
export TERM=xterm-256color

# Add custom scripts folder to bash path
export PATH="$PATH:~/.scripts"

# Prompt
parse_git_branch() {
     BRANCH=`git branch 2> /dev/null | grep -e '^* ' | egrep -o '([a-z]+/[A-Z]+-[0-9]+)'`
     if [ ! -z "$BRANCH" ]; then
         echo "[$BRANCH]"
     fi
}

export CLICOLOR=1

# Uncolored (fail safe) PS1
export PS1='\u@\h:\W `parse_git_branch`\$ '

if [ ! -z "CLICOLOR" ]; then
    export PS1='\[$(tput setaf 2)\]\[$(tput bold)\]\u@\h:\[$(tput setaf 4)\]\W \[$(tput setaf 3)\]`parse_git_branch`\[$(tput sgr0)\$\] '
fi

# Used for colored psychedelic manpages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;31m'

# Bash aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Platform-specific configurations

# GNU/linux
if [ `uname` == "Linux" ]; then
    # Dictionary aliases (dictd, gcide and freedict-eng-spa required)
    alias enspa='dict -d fd-eng-spa'
    alias spaen='dict -d fd-spa-eng'
fi

# macOS / OSX
if [ `uname` == "Darwin" ]; then
    export PATH=/opt/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.vimpkg/bin

    # Bash completion from MacPorts
    if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
        source /opt/local/etc/profile.d/bash_completion.sh
    fi

    # Lang C, country Unix
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8

    alias vim="/opt/local/bin/vim"
fi
