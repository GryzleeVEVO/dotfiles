#
# .bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Environmental values and custom PATH are loaded in .profile during login

# Aliases
[[ -f "$XDG_CONFIG_HOME/aliases/aliases" ]] &&
    source "$XDG_CONFIG_HOME/aliases/aliases"

# Fancy ls colors
[[ -f "$XDG_CONFIG_HOME/dircolors/dircolors" ]] &&
    eval "$(dircolors $XDG_CONFIG_HOME/dircolors/dircolors)"

# NVM
[[ -f "/usr/share/nvm/init-nvm.sh" ]] &&
    source /usr/share/nvm/init-nvm.sh

# Command not found message for Pacman
[[ -f "/usr/share/doc/pkgfile/command-not-found.bash" ]] &&
    source /usr/share/doc/pkgfile/command-not-found.bash

# Use vim keybindings
set -o vi

# Reset window size after each command
shopt -s checkwinsize

################################################################################
# HISTORY                                                                      #
################################################################################

# History file
[[ ! -z "$XDG_CACHE_HOME" ]] &&
    HISTFILE="$XDG_CACHE_HOME/history" ||
    HISTFILE="$HOME/.history"

# Don't store duplicates or lines starting with space
HISTCONTROL=erasedups:ignoreboth

# Ignore one and two character commands, as well as some common commands
HISTIGNORE="?:??:&:c:cl:clr:cls:exit:quit:q:history:h:l:ls:ll:la"

# History file size
HISTFILESIZE=50000

# History buffer size
HISTSIZE=10000

# Append to history file instead of overwriting
shopt -s histappend

# Put failed history substitution back on prompt
shopt -s histreedit

# Don't execute history substitution immediately
shopt -s histverify

################################################################################
# Autocompletion and globbing                                                  #
################################################################################

# CDPATH acts as a PATH for the cd command
# CDPATH=".:$HOME"

# Correct spelling errors in cd
shopt -s cdspell

# Let ** search all directories recursively
shopt -s globstar

# Case insensitive globbing
shopt -s nocaseglob

# Don't complete empty prompt
shopt -s no_empty_cmd_completion

# Automatically cd into directories
[[ "${BASH_VERSINFO[0]}" -ge 4 ]] &&
    shopt -s autocd

# Allow programmable completion of aliases
[[ "${BASH_VERSINFO[0]}" -ge 5 ]] &&
    shopt -s progcomp_alias

################################################################################
# PROMPT                                                                       #
################################################################################

# Show last 3 directories in cwd
PROMPT_DIRTRIM=3

# Append to history every time the prompt is redrawn
PROMPT_COMMAND="history -a"

# Print git repository status. If there are uncommited files, mark it
__prompt__git__status__() {
    local GIT_DIRTY GIT_BRANCH

    if [[ $(git status --porcelain 2>/dev/null) ]]; then
        GIT_DIRTY=" *"
    else
        GIT_DIRTY=""
    fi

    GIT_BRANCH="$(git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/( \1${GIT_DIRTY})/")"

    echo -e "${GIT_BRANCH}"
}

# Returns colored exit status between brackets
__prompt__exit__status__() {
    local EXIT="$?" COLOR_RESET="$(tput sgr0)" COLOR_EXIT

    if [[ $EXIT = 0 ]]; then
        COLOR_EXIT="$(tput setaf 118)"
    else
        COLOR_EXIT="$(tput setaf 196)"
    fi

    echo -e "${COLOR_EXIT}[${EXIT}]${COLOR_RESET}"
}

PS1=""

# Exit status
PS1+='┌$(__prompt__exit__status__) '

# Username
PS1+='\[$(tput setaf 216)\]'
PS1+='\u'

# Add "@hostname" if it is a remote connection
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    PS1+='\[$(tput setaf 222)\]'
    PS1+='@\h'
fi

PS1+=' '

# Path to workdir
PS1+='\[$(tput setaf 229)\]'
PS1+='\w '

# Git status
PS1+='\[$(tput setaf 208)\]'
PS1+='$(__prompt__git__status__) '

# End of prompt
PS1+='\[$(tput sgr0)\]\n'
PS1+='└─$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*) ;;
esac
