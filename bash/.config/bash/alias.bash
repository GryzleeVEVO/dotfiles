#!/bin/bash
#
# Convenient aliases for interactice shell
#

#
# cd
#
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../'
alias .......='cd ../../../../..'

#
# clear
#
alias c="clear"
alias cl='clear'
alias clr='clear'

#
# cp
#
alias cp='cp --verbose --interactive --recursive'

#
# diff
#
alias diff='diff --color=auto'

#
# exit
#
alias q='exit'
alias quit='exit'

#
# grep
#
alias grep='grep --color=auto'
alias egrep='grep --extended-regexp'
alias fgrep='grep --fixed-strings'

#
# history
#
alias h='history'

#
# ln
#
alias ln='ln --verbose --interactive'

#
# ls
#
alias l='ls'
alias ls='ls --color=auto --human-readable'
alias la='ls --all'
alias ll='ls --all -l'

#
# mkdir
#
alias mkdir='mkdir --verbose --parents'

#
# mv
#
alias mv='mv --verbose --interactive'

#
# rm
#
alias rm='rm --verbose --dir --recursive --interactive=once'

#
# source
#
alias reload='source $HOME/.bashrc'

#
# systemctl
#
alias sctl='sudo systemctl status'
alias sctle='sudo systemctl enable'
alias sctls='sudo systemctl start'
alias sctlr='sudo systemctl reload'
alias sctlrs='sudo systemctl restart'
alias sctlrr='sudo systemctl reload-or-restart'

#
# thrash
#
alias th='gio trash'
alias lsth='gio thrash -l'

#
# wget
#
alias wget='wget -c'

################################################################################

# Quick access to some ssh hosts
sshx() {
    ssh -X a817570@$@.cps.unizar.es
}

# Access relevant dotfiles quickly
cfg() {
    local CONFIG_PATH=$HOME/.config

    [ $# -eq 0 ] && echo "cfg: No arguments" && return 1
    [ $# -ne 1 ] && echo "cfg: Only one argument at a time" && return 1

    case $1 in
    alacritty | i3 | picom | polybar)
        $EDITOR $CONFIG_PATH/$1
        ;;
    bash)
        $EDITOR $BASH_CONFIG_PATH
        ;;
    bashrc)
        $EDITOR $HOME/.bashrc
        ;;
    *)
        echo ": Invalid argument" && return 1
        ;;
    esac

    return 0
}

# Commit changes in dotfiles and restow
dot() {
    if pushd $HOME/.dotfiles &>/dev/null; then
        git add *
        git commit -m "$(date '+%Y/%m/%d %H:%M') $@"
        stow --restow --target=$HOME */
        popd &>/dev/null
    fi
}

# Generate document from markdown file with pandoc
mdgen() {
    [ $# -eq 0 ] && echo "mdgen: No arguments" && return 1

    for f in $@; do
        pandoc $f \
            -f markdown \
            --pdf-engine=xelatex \
            --highlight-style kate \
            -V geometry:a4paper \
            -V geometry:margin=2cm \
            -V documentclass=report \
            -V lang=es-ES \
            --toc \
            --top-level-division=chapter \
            -N \
            -o "$(basename $f .md).pdf"
    done
}
