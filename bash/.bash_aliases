# cd
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../'
alias .......='cd ../../../../..'

# clear
alias c='clear'
alias cl='clear'
alias clr='clear'

# cp
alias cp='cp -v --interactive --recursive'

# diff
alias diff='diff --color=auto'

# du/df
alias du='du -h'
alias df='df -h'

# exit
alias q='exit'
alias quit='exit'

# git
alias g='git'

push() {
    if git status -s &>/dev/null; then
        git add ./*
        git commit -am "$(date '+%Y/%m/%d %H:%M') $*"
        git push
    fi
}

pull() {
    git pull "$@"
}

# grep
alias grep='grep --color=auto'
alias egrep='grep --extended-regexp'
alias fgrep='grep --fixed-strings'

# history
alias h='history'

# ln
alias ln='ln -v --interactive'

# ls
alias ls='ls -h -F --color=auto --group-directories-first'
alias l='ls'
alias la='ls -a'
alias ll='ls -a -l'

# make
alias m='make'

# mkdir
alias mkdir='mkdir -p -v'

# mv
alias mv='mv -v --interactive'

# pacman/yay
alias p='yay'
alias psy='yay -Syu'
alias prm='yay -R'
alias pe='yay -Qe'
alias pqs'yay -Qss'
alias pss='yay -Ss'

# reload
if [ "$0" = "/bin/bash" ] || [ "$0" = "bash" ]; then
    alias reload='source $HOME/.bashrc'
else
    alias reload='source $HOME/.zshrc'
fi

alias r='reload'

# rm
alias rm='rm -v --dir --recursive --interactive=once'

# ssh
sshx() {
    ssh -X "a817570@${1}.cps.unizar.es"
}

# stow
dot() {
    if pushd "$HOME/.dotfiles" &>/dev/null; then
        git add ./*
        git commit -m "$(date '+%Y/%m/%d %H:%M') $*"
        stow --target="$HOME" -- *glob*
        popd &>/dev/null || return
    fi
}
