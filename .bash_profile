
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
export PS1='\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\[\033[00m\]\[\033[38;5;221m\] `parse_git_branch`\e[m\]\$ '

# Used for colored psychedelic manpages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Platform-specific configurations

# GNU/linux
if [ `uname` == "Linux" ]; then
fi

# macOS / OSX
if [ `uname` == "Darwin" ]; then
    export PATH=/opt/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.vimpkg/bin

    # Bash completion from MacPorts
    if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
        source /opt/local/etc/profile.d/bash_completion.sh
    fi

    # Lang C, country Unix
    export LC_ALL=C
fi
