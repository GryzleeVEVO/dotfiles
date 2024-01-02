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
    local GIT_DIRTY GIT_BRANCH COLOR_VCS RESET_COLOR
    COLOR_VCS="$(tput setaf 226)"
    RESET_COLOR="$(tput sgr0)"

    [[ $(git status --porcelain 2>/dev/null) ]] && GIT_DIRTY=" *" || GIT_DIRTY=""
    GIT_BRANCH="$(git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1${GIT_DIRTY})/")"

    echo "${COLOR_VCS}${GIT_BRANCH}${RESET_COLOR}"
}

# Returns exit status
__exit__status__() {
    local EXIT="$?" COLOR_EXIT RESET_COLOR
    RESET_COLOR="$(tput sgr0)"
    [[ $EXIT = 0 ]] && COLOR_EXIT="$(tput setaf 10)" || COLOR_EXIT="$(tput setaf 9)"

    echo "${COLOR_EXIT}[${EXIT}]${RESET_COLOR}"
}

# Prompt: [x] user@host ~/pwd (branch *) $
__set__prompt__() {
    local RESET_COLOR COLOR_USER COLOR_AT COLOR_HOST COLOR_PWD PROMPT
    RESET_COLOR="$(tput sgr0)"
    COLOR_USER="$(tput setaf 39)"
    COLOR_AT="$(tput setaf 45)"
    COLOR_HOST="$(tput setaf 51)"
    COLOR_PWD="$(tput setaf 192)"

    PROMPT="\$(__exit__status__) "
    PROMPT+="${COLOR_USER}\u"
    PROMPT+="${COLOR_AT}@"
    PROMPT+="${COLOR_HOST}\h "
    PROMPT+="${COLOR_PWD}\w"
    PROMPT+="\$(__vcs__status__) "
    PROMPT+="${RESET_COLOR}$ "

    echo "${PROMPT}"
}

# Broken
# PS1="$(__set__prompt__)"

# Execute each time prompt is drawn
__prompt__command__() {
    history -a
}

# Enable completion
if [[ -f "/usr/share/bash-completion/bash_completion" ]]; then
    source "/usr/share/bash-completion/bash_completion"
fi

PROMPT_COMMAND="__prompt__command__"

# History file
HISTFILE="$HOME/.history"

# Erase duplicates, trim whitespace
HISTCONTROL=erasedups:ignoreboth

# Commands to ignore in history
HISTIGNORE=""

# Size of history file
HISTFILESIZE=50000

# Size of history in memory
HISTSIZE=10000

# Append to history file
shopt -s histappend

# Let reedit failed substitutions
shopt -s histreedit

# Don't execute immediately after history substitution
shopt -s histverify

# Autocorrect cd typos
shopt -s cdspell

# Recursive expansion
shopt -s globstar

# Case-insensitive globbing
shopt -s nocaseglob

# Do not autocomplete with empty prompt
shopt -s no_empty_cmd_completion

# cd into directories by typing their name
[ "${BASH_VERSINFO[0]}" -ge 4 ] && shopt -s autocd

# Autocomplete aliases
[ "${BASH_VERSINFO[0]}" -ge 5 ] && shopt -s progcomp_alias
