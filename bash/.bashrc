# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Use emacs keybindings
set -o emacs

# Reset window size after each command
shopt -s checkwinsize

# Set up VCS info
__vcs__status__() {
    local GIT_DIRTY GIT_BRANCH

    if [[ $(git status --porcelain 2>/dev/null) ]]; then
        GIT_DIRTY=" *"
    else
        GIT_DIRTY=""
    fi

    GIT_BRANCH="$(git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1${GIT_DIRTY})/")"

    echo -e "${GIT_BRANCH}"
}

# Returns exit status
__exit__status__() {
    local EXIT="$?" COLOR_EXIT

    if [[ $EXIT = 0 ]]; then
        COLOR_EXIT="\001\e[38;5;10m\002"
    else
        COLOR_EXIT="\001\e[38;5;9m\002"
    fi

    echo -e "${COLOR_EXIT}[${EXIT}]\001$(tput sgr0)\002"
}

# Prompt: [?] user@host ~/path/to/dir (branch *) $
PS1="\$(__exit__status__) "
PS1+="\[\e[38;5;14m\]\u"
[[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]] && PS1+="@\h"
PS1+=" \[\e[38;5;4m\]\w\[\e(B\e[m\]"
PS1+="\[\e[38;5;8m\]\$(__vcs__status__) "
PS1+="\[\e(B\e[m\]\$ "

# Execute each time prompt is drawn
__prompt__command__() {
    history -a
}

PROMPT_COMMAND="__prompt__command__"

# Enable completion
if [[ -f "/usr/share/bash-completion/bash_completion" ]]; then
    source "/usr/share/bash-completion/bash_completion"
fi

HISTFILE="$HOME/.history"        # History file
HISTCONTROL=erasedups:ignoreboth # Don't store duplicates or lines starting with space
HISTIGNORE=""                    # Ignore these commands
HISTFILESIZE=50000               # History file size
HISTSIZE=10000                   # History buffer size

shopt -s histappend                # Append to history file instead of overwriting
shopt -s histreedit                # Put failed history substitution back on prompt
shopt -s histverify                # Don't execute history substitution immediately
shopt -s cdspell                   # Correct spelling errors in cd
shopt -s globstar                  # Let ** recurse all directories
shopt -s nocaseglob                # Case insensitive globbing
shopt -s no_empty_cmd_completion   # Don't complete empty prompt
[ "${BASH_VERSINFO[0]}" -ge 4 ] && #
    shopt -s autocd                # Automatically cd into directories
[ "${BASH_VERSINFO[0]}" -ge 5 ] && #
    shopt -s progcomp_alias        # Allow completion of aliases
