alias cd..='cd ..'                                   # cd
alias ..='cd ..'                                     #
alias ...='cd ../../../'                             #
alias ....='cd ../../../../'                         #
alias .....='cd ../../../../'                        #
alias ......='cd ../../../../'                       #
alias .......='cd ../../../../..'                    #
alias c='clear'                                      # clear
alias cl='clear'                                     #
alias clr='clear'                                    #
alias q='exit'                                       # exit
alias quit='exit'                                    #
if [ "$0" = "/bin/bash" ] || [ "$0" = "bash" ]; then # reload
    alias reload='source $HOME/.bashrc'              #
else                                                 #
    alias reload='source $HOME/.zshrc'               #
fi                                                   #
alias r='reload'                                     #
alias h='history'                                    #
alias g='git'                                        # git
alias p='yay -Syu'                                   # pacman/yay
alias prm='yay -R'                                   #
alias plist='yay -Q'                                 #
alias pquery='yay -Qss'                              #
alias pss='yay -Ss'                                  #

# ------------------------------------------------------------------------------

alias ls='ls -h -F'
alias l='ls'
alias la='ls -a'
alias ll='ls -a -l'

alias mkdir='mkdir -p'

# Some aliases use GNU-specific flags
if [ "$(uname)" = Linux ]; then
    alias m='make'

    alias ls='ls -h -F --color=auto --group-directories-first'

    alias mkdir='mkdir -p -v'
    alias ln='ln -v --interactive'
    alias rm='rm -v --dir --recursive --interactive=once'

    alias cp='cp -v --interactive --recursive'
    alias mv='mv -v --interactive'

    alias diff='diff --color=auto'

    alias grep='grep --color=auto'
    alias egrep='grep --extended-regexp'
    alias fgrep='grep --fixed-strings'
# Else, assume SunOS/Solaris/BSD
else
    alias m='gmake'
fi

# ------------------------------------------------------------------------------

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
