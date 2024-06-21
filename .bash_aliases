# Git aliases
alias gb='git branch'
alias gca='git add . && git commit -a'
alias gs='git status'
alias gl='git log'
alias gp='git pull'
alias gpp='git push'
alias gcp='git checkout'

# Console utilities
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -l'
alias la='ls -lgh'
alias l='ls -CF'

# Fancy stuff
alias ccat='highlight -s dusk -O xterm256'
alias weather='curl https://wttr.in/Palma'

# Development
alias dps='docker ps'

# Vim
alias vim='nvim'

# Only GNU/linux
if [ `uname` == "Linux" ]; then
    alias ls='ls --color=auto'
fi

# Only macOS
if [ `uname` == "Darwin" ]; then
    alias ls='ls -G'
fi

