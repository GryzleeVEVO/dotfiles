# Useful defaults

alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../'
alias .......='cd ../../../../..'

alias c='clear'
alias cl='clear'
alias clr='clear'

alias q='exit'
alias quit='exit'

alias r='source $HOME/.bashrc'
alias reload='source $HOME/.bashrc'

alias h='history'

alias l='ls -hF'
alias la='ls -a'
alias ll='ls -a -l'

alias g='git'

alias p='yay -Syu'
alias pr='yay -R'
alias pq='yay -Qs'
alias ps='yay -Ss'
alias pcl='yay -Rsu $(yay -Qqtd)'

# Some aliases use GNU-specific flags
if [ "$(uname)" = Linux ]; then
    alias m='make'

    alias ls='ls -F --color=auto --human-readable --group-directories-first'

    alias mkdir='mkdir --verbose --parents'
    alias ln='ln --verbose --interactive'
    alias rm='rm --verbose --dir --recursive --interactive=once'

    alias cp='cp --verbose --interactive --recursive'
    alias mv='mv --verbose --interactive'

    alias diff='diff --color=auto'

    alias grep='grep --color=auto'
    alias egrep='grep --extended-regexp'
    alias fgrep='grep --fixed-strings'
fi

# Generate document from markdown file with pandoc
docgen() {
    [ $# -eq 0 ] && echo "docgen: No arguments" && return 1

    for f in "$@"; do
        pandoc "$f" \
            -f markdown \
            --pdf-engine=xelatex \
            -o "$(basename "$f" .md).pdf"
    done
}

# Quick access to university ssh hosts
sshx() {
    ssh -X "a817570@${1}.cps.unizar.es"
}

# Add files, commit and push
push() {
    if git status -s &>/dev/null; then
        git add ./*
        git commit -am "$(date '+%Y/%m/%d %H:%M') $*"
        git push
    fi
}

# Pull
pull() {
    git pull "$@"
}

# Commit changes in dotfiles and restow
dot() {
    if pushd "$HOME/.dotfiles" &>/dev/null; then
        git add ./*
        git commit -m "$(date '+%Y/%m/%d %H:%M') $*"
        stow --restow --target="$HOME" ./*/
        popd &>/dev/null || return
    fi
}
