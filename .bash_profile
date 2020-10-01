export EDITOR=vim
export VISUAL=vim
export TERM=xterm-256color

# Prompt
parse_git_branch() {
    [ -d "$CWD/.git" ] && return
    # This expects a branch named in this form 'feature/ABCD-1234-add-new-feature'
    BRANCH=`git branch 2> /dev/null | grep -e '^* ' | egrep -o '([a-z/?]*[A-Z]+-[0-9]+|^release)'`
    [ ! -z "$BRANCH" ] && echo "[$BRANCH]"
}

export PS1='\[\033[01;32m\]\u@\h:\[\033[01;34m\]\W\[\033[01;33m\]$(parse_git_branch)\[\033[0m\]\$ '

# Man pages counter and %
export MANPAGER='less -s -M +Gg'

# Man in full color
man() {
    LESS_TERMCAP_md=$'\e[01;34m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[00;40;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# Bash aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# General path entries
export PATH="$HOME/.scripts:$PATH"

# Only GNU/linux
if [ `uname` == "Linux" ]; then
    # Dictionary aliases (dictd, gcide and freedict-eng-spa required)
    alias enspa='dict -d fd-eng-spa'
    alias spaen='dict -d fd-spa-eng'
    # Needed to specify Qt themes
    # export QT_QPA_PLATFORMTHEME=qt5ct
    # Wine32
    # export WINEPREFIX=$HOME/.wine32
fi

# Only macOS
if [ `uname` == "Darwin" ]; then
    export PATH="/opt/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.vimpkg/bin:$PATH"
    # Bash completion from MacPorts
    if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
        source /opt/local/etc/profile.d/bash_completion.sh
    fi
    # MacTEX LaTeX distribution binaries:
    export "PATH=$PATH:/usr/local/texlive/2019/bin/x86_64-darwin"
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
    alias vim="/opt/local/bin/vim"
    export PATH="$HOME/.cargo/bin:/opt/metasploit-framework/bin:$PATH"
    # Fuck apple using zsh as default
    export BASH_SILENCE_DEPRECATION_WARNING=1
fi
