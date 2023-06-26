# .bashrc

# Sources
# https://github.com/mrzool/bash-sensible/blob/master/sensible.bash
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html

[[ $- != *i* ]] && return # If not running interactively, don't do anything

# Source aliases
[[ -f "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases"

# * PROMPT
prompt_setup() {
    # https://stackoverflow.com/questions/16715103/bash-prompt-with-the-last-exit-code
    # https://www.gnu.org/software/bash/manual/html_node/Controlling-the-Prompt.html
    # https://unix.stackexchange.com/questions/269077/tput-setaf-color-table-how-to-determine-color-codes
    # https://code.mendhak.com/simple-bash-prompt-for-developers-ps1-git/

    local EXIT="$?" # Exit status of last command

    history -a # Append last command

    local COLOR_RED="\[$(tput setaf 9)\]" # Colors
    local COLOR_GREEN="\[$(tput setaf 10)\]"
    local COLOR_39="\[$(tput setaf 39)\]"
    local COLOR_45="\[$(tput setaf 45)\]"
    local COLOR_51="\[$(tput setaf 51)\]"
    local COLOR_192="\[$(tput setaf 192)\]"
    local COLOR_226="\[$(tput setaf 226)\]"
    local COLOR_RESET="\[$(tput sgr0)\]"

    # Git repository status
    [[ $(git status --porcelain 2>/dev/null) ]] && GIT_DIRTY=" *" || GIT_DIRTY=""

    GIT_BRANCH=$(git branch --no-color 2>/dev/null |
        sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1${GIT_DIRTY})/")

    PS1=""
    [ $EXIT = 0 ] && PS1="${PS1}${COLOR_GREEN}" || PS1="${PS1}${COLOR_RED}"
    PS1="${PS1}[${EXIT}] "                 # [exit code]
    PS1="${PS1}${COLOR_39}\u"              # user
    PS1="${PS1}${COLOR_45}@"               # @
    PS1="${PS1}${COLOR_51}\h "             # host
    PS1="${PS1}${COLOR_192}\w"             # pwd
    PS1="${PS1}${COLOR_226}\${GIT_BRANCH}" # (branch *)
    PS1="${PS1}${COLOR_RESET} $ "          # $

    PROMPT_DIRTRIM=3 # Number of directories shown
}

PROMPT_COMMAND=prompt_setup

# * HISTORY

set -o histexpand # Enable expansion with !!

shopt -s cmdhist    # Save multi-line commands as one
shopt -s histappend # Append new entries instead of overwriting
shopt -s histreedit # If search fails, paste command in prompt for editing
shopt -s histverify # If search suceeds, paste command in prompt instead of running

HISTCONTROL=erasedups:ignoreboth                # Ignore and erase duplicates, trim leading whitespaces
HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear" # Ignore some commands
HISTFILESIZE=50000                              # Size of history file
HISTSIZE=10000                                  # Size of current history buffer
HISTTIMEFORMAT='%F %T '                         # Timestamp (YY-mm-dd HH:MM:SS)

bind Space:magic-space                 # Autoexpand history after space
bind '"\e[A": history-search-backward' # Incremental history search with arrows
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

# * AUTOCOMPLETE/EXPANSION

set -o braceexpand # Enable brace expansion
set +o noglob      # (disabled) Disable globbing

shopt -s cdspell                 # Autocorrect minor typos when using cd
shopt -s cdable_vars             # Enable cd-ing to path stored in variable
shopt -s extglob                 # Extended globbing
shopt -s nocaseglob              # Case-insensitive globbing
shopt -s no_empty_cmd_completion # Don't show autocompletion for empty prompt

# If command is name of directory, cd into it
[ "${BASH_VERSINFO:-0}" -ge 4 ] && shopt -s autocd

# If alias exists, tries autocompletion for command
[ "${BASH_VERSINFO:-0}" -ge 5 ] && shopt -s progcomp_alias

bind "set completion-map-case on"        # Case-insensitive file completion
bind "set show-all-if-ambiguous on"      # Display ambiguous matches
bind "set mark-symlinked-directories on" # Autocomplete for symlink directories

set -o emacs # Use emacs or vi style input+
set +o vi

shopt -s checkwinsize # Update screen size after each command

# * VARIABLES

# Default editor
if command -v nvim &>/dev/null; then
    export EDITOR='nvim'
elif command -v vim &>/dev/null; then
    export EDITOR='vim'
else
    export EDITOR='vi'
fi

set -o history # Enable history (if not set already)
