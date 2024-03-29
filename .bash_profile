export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox
export TERM=xterm-256color

# Prompt
parse_git_branch() {
    [ -d "$CWD/.git" ] && return
    # This expects a branch named in this form 'feature/ABCD-1234-add-new-feature'
    BRANCH=`git branch 2> /dev/null | grep -e '^* ' | egrep -Eo '([A-Za-z0-9\/\-]+)'`
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
export PATH="$HOME/.scripts:$HOME/.local/bin:$PATH"

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
    export PATH="/opt/local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.vimpkg/bin:$PATH"
    # Bash completion from MacPorts
    if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
        source /opt/local/etc/profile.d/bash_completion.sh
    fi

    # Bash completion from HomeBrew
    if [ -d /usr/local/etc/bash_completion.d ]; then
        source /usr/local/etc/bash_completion.d/*
    fi

    # FZF search for bash in macOS
    if [ -f /opt/local/share/fzf/shell/completion.bash ]; then
        source /opt/local/share/fzf/shell/completion.bash
    fi

    export PATH="/Users/nicolaspalumbo/.local/bin:/opt/metasploit-framework/bin:/usr/local/texlive/2021/bin/universal-darwin:/Users/nicolaspalumbo/Library/Python/3.9/bin:$PATH"
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8

    # Fuck apple using zsh as default
    export BASH_SILENCE_DEPRECATION_WARNING=1

    # Needed for some legacy X11 applications
    export DISPLAY=:0
    test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

    # Homebrew node
    export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/node@16/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/node@16/include"

    # In my company they put a very ugly name to my computer
    MACHINE_NAME=$(hostname | cut -d'.' -f1 | tr '[:upper:]' '[:lower:]')
    [[ "$MACHINE_NAME" == "foxy" ]] || MACHINE_NAME="grunt"

    # Git bash autocompletion
    if [ -f ~/.git-completion.bash ]; then
      . ~/.git-completion.bash
    fi

    # Set the PS1 for macOS
    export PS1='\[\033[01;32m\]\u@$MACHINE_NAME:\[\033[01;34m\]\W\[\033[01;33m\]$(parse_git_branch)\[\033[0m\]\$ '

    if type brew &>/dev/null
    then
      HOMEBREW_PREFIX="$(brew --prefix)"
      if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
      then
        source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
      else
        for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
        do
          [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
        done
      fi
    fi

fi
