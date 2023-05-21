# bashrc

# Sources
# https://github.com/mrzool/bash-sensible/blob/master/sensible.bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# *** PROMPT ***

# Set up the prompt
prompt_setup() {
    # Exit status of last command
    # https://stackoverflow.com/questions/16715103/bash-prompt-with-the-last-exit-code
    local EXIT="$?"

    # Append last command
    history -a

    # Prompt variables
    # https://www.gnu.org/software/bash/manual/html_node/Controlling-the-Prompt.html
    local PROMPT_USER='\u'
    local PROMPT_HOST='\h'
    local PROMPT_DIR='\w'

    # Colors
    # https://unix.stackexchange.com/questions/269077/tput-setaf-color-table-how-to-determine-color-codes
    local COLOR_RED="\[$(tput setaf 9)\]"
    local COLOR_GREEN="\[$(tput setaf 10)\]"

    local COLOR_39="\[$(tput setaf 39)\]"
    local COLOR_45="\[$(tput setaf 45)\]"
    local COLOR_51="\[$(tput setaf 51)\]"
    local COLOR_192="\[$(tput setaf 192)\]"
    local COLOR_226="\[$(tput setaf 226)\]"
    local COLOR_RESET="\[$(tput sgr0)\]"

    # Git repository status
    # Adapted from https://code.mendhak.com/simple-bash-prompt-for-developers-ps1-git/
    GIT_DIRTY=""
    [[ $(git status --porcelain 2>/dev/null) ]] && GIT_DIRTY=" *"

    GIT_BRANCH=$(git branch --no-color 2>/dev/null |
        sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1${GIT_DIRTY})/")

    # Format:
    # [exit code] user@host /.../path/to/dir (branch *) $
    PS1=""
    [ $EXIT = 0 ] && PS1+="${COLOR_GREEN}" || PS1+="${COLOR_RED}"
    PS1+="[${EXIT}] "
    PS1+="${COLOR_39}${PROMPT_USER}"
    PS1+="${COLOR_45}@"
    PS1+="${COLOR_51}${PROMPT_HOST} "
    PS1+="${COLOR_192}${PROMPT_DIR}"
    PS1+="${COLOR_226}\${GIT_BRANCH}"
    PS1+="${COLOR_RESET} $ "

    # Number of directories shown
    PROMPT_DIRTRIM=3
}

# Run prompt_setup every time the prompt is updated
PROMPT_COMMAND=prompt_setup

# *** HISTORY ***

# Set up history
history_setup() {
    # Enable history
    set -o history

    # Enable expansion with !!
    set -o histexpand

    # Save multi-line commands as one
    shopt -s cmdhist

    # Append new entries instead of overwriting
    shopt -s histappend

    # If search fails, paste command in prompt for editing
    shopt -s histreedit

    # If search suceeds, paste command in prompt instead of running
    shopt -s histverify

    # Ignore and erase duplicates, trim leading whitespaces
    HISTCONTROL=erasedups:ignoreboth

    # Ignore some commands
    HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

    # Size of history file
    HISTFILESIZE=50000

    # Timestamp (YY-mm-dd HH:MM:SS)
    HISTTIMEFORMAT='%F %T '

    # Size of current history buffer
    HISTSIZE=10000

    # Autoexpand history after space
    bind Space:magic-space

    # Incremental history search with arrows
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
    bind '"\e[C": forward-char'
    bind '"\e[D": backward-char'

}

# *** COMPLETION ***

completion_setup() {
    # Enable brace expansion
    set -o braceexpand

    # (disabled) Disable globbing
    set +o noglob

    # If command is name of directory, cd into it
    shopt -s autocd

    # Autocorrect minor typos when using cd
    shopt -s cdspell

    # Enable cd-ing to path stored in variable
    shopt -s cdable_vars

    # Extended globbing
    shopt -s extglob

    # Case-insensitive globbing
    shopt -s nocaseglob

    # Don't show autocompletion for empty prompt
    shopt -s no_empty_cmd_completion

    # If alias exists, tries autocompletion for command
    shopt -s progcomp_alias

    # Case-insensitive file completion
    bind "set completion-map-case on"

    # Display matches for ambiguous patterns at first tab press
    bind "set show-all-if-ambiguous on"

    # Immediately add a trailing slash when autocompleting symlinks to directories
    bind "set mark-symlinked-directories on"
}

completion_setup


# *** MISCELLANEOUS OPTIONS ***
# More oprtions
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html

options_setup() {
    # Use emacs or vi style input+
    set -o emacs
    set +o vi

    # Update screen size after each command
    shopt -s checkwinsize
}

options_setup

# *** DEFAULT PROGRAMS ***

if command -v nvim &>/dev/null; then
    EDITOR='nvim'
elif command -v vim &>/dev/null; then
    EDITOR='vim'
fi

# *** SCRIPTS ***

# Access relevant dotfiles quickly
#cfg() {
#    local CONFIG_PATH=$HOME/.config
#
#    [ $# -eq 0 ] && echo "cfg: No arguments" && return 1
#    [ $# -ne 1 ] && echo "cfg: Only one argument at a time" && return 1
#
#     case $1 in
#     alacritty | i3 | picom | polybar)
#         $EDITOR $CONFIG_PATH/$1
#         ;;
#     bash)
#         $EDITOR $BASH_CONFIG_PATH
#         ;;
#     bashrc)
#         $EDITOR $HOME/.bashrc
#         ;;
#     *)
#         echo ": Invalid argument" && return 1
#         ;;
#     esac

#     return 0
# }

# Generate document from markdown file with pandoc
docgen() {
    [ $# -eq 0 ] && echo "docgen: No arguments" && return 1

    for f in $@; do
        pandoc $f \
            -f markdown \
            --pdf-engine=xelatex \
            -o "$(basename $f .md).pdf"
    done
}

# Quick access to university ssh hosts
sshx() {
    ssh -X a817570@$@.cps.unizar.es
}

# Add files, commit and push
push() {
    if git status -s &>/dev/null; then
        git add *
        git commit -am "$(date '+%Y/%m/%d %H:%M') $@"
        git push
    fi
}

# Pull
pull() {
    git pull $@
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

# *** ALIASES ***

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


history_setup
