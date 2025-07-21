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

# Poetry
export PATH="~/.local/bin:$PATH"

# WSL
[ -f ~/.bash_windows ] && source ~/.bash_windows

# Only macOS
if [ `uname` == "Darwin" ]; then
    export HB="/opt/homebrew"
    export PATH="$HB/bin:$HB/opt/postgresql@16/bin:$HB/opt/util-linux/bin:$HB/opt/make/libexec/gnubin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HB/opt/openjdk@11/bin:$HB/opt/curl/bin:$PATH"

    # Fuck apple using zsh as default
    export BASH_SILENCE_DEPRECATION_WARNING=1

    # Change the horrible name my company put to the work laptop
    REGISTERED_NAMES=("foxy" "apollo")
    MACHINE_NAME=$(hostname | cut -d'.' -f1 | tr '[:upper:]' '[:lower:]')

    case " ${REGISTERED_NAMES[*]} " in
      *" $MACHINE_NAME "*)
        ;;
      *)
        MACHINE_NAME="osiris"
        ;;
    esac

    # nodejs installed with brew (not automatic linking for this package)
    export PATH="$HB/opt/node@18/bin:$PATH"
    export LDFLAGS="-L$HB/opt/node@18/lib"
    export CPPFLAGS="-I$HB/opt/node@18/include"

    # Generic paths for versioned packages
    NODE_BIN=$(brew --prefix node)/bin
    PYTHON_BIN=$(brew --prefix python)/libexec/bin
    export PATH="$PATH:$PYTHON_BIN:$NODE_BIN"

    # Wezterm
    export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

    # Set the PS1 for macOS
    export PS1='\[\033[01;32m\]\u@$MACHINE_NAME:\[\033[01;34m\]\W\[\033[01;33m\]$(parse_git_branch)\[\033[0m\]\$ '

    # rust
    [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

    # Homebrew
    export HOMEBREW_NO_ENV_HINTS=1
    if type brew &>/dev/null
    then
        if [[ -r "${HB}/etc/profile.d/bash_completion.sh" ]]
        then
            source "${HB}/etc/profile.d/bash_completion.sh"
        else
            for COMPLETION in "${HB}/etc/bash_completion.d/"*
            do
                [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
            done
        fi
    fi

    [[ -r "$HB/etc/profile.d/bash_completion.sh" ]] && . "$HB/etc/profile.d/bash_completion.sh"
fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/shaggyz/.cache/lm-studio/bin"
