# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source aliases (only if on Linux)
if [[ -f "$HOME/.bash_aliases" ]] && [ "$(uname)" = "Linux" ]; then
    source "$HOME/.bash_aliases"
fi

prompt_setup() {
    local EXIT="$?" # Exit status of last command

    history -a # Append last command

    local COLOR_RED="\[$(tput setaf 9)\]"
    local COLOR_GREEN="\[$(tput setaf 10)\]"
    local COLOR_39="\[$(tput setaf 39)\]"
    local COLOR_45="\[$(tput setaf 45)\]"
    local COLOR_51="\[$(tput setaf 51)\]"
    local COLOR_192="\[$(tput setaf 192)\]"
    local COLOR_226="\[$(tput setaf 226)\]"
    local COLOR_RESET="\[$(tput sgr0)\]"

    # Git repository status
    [[ $(git status --porcelain 2>/dev/null) ]] && GIT_DIRTY=" *" || GIT_DIRTY=""

    GIT_BRANCH="$(git branch --no-color 2>/dev/null |
        sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1${GIT_DIRTY})/")"

    PS1=""
    [ $EXIT = 0 ] && PS1="${PS1}${COLOR_GREEN}" || PS1="${PS1}${COLOR_RED}"
    PS1="${PS1}[${EXIT}] "                 # [exit code]
    PS1="${PS1}${COLOR_39}\u"              # user
    PS1="${PS1}${COLOR_45}@"               # @
    PS1="${PS1}${COLOR_51}\h "             # host
    PS1="${PS1}${COLOR_192}\w"             # pwd
    PS1="${PS1}${COLOR_226}${GIT_BRANCH}" # (branch *)
    PS1="${PS1}${COLOR_RESET} $ "          # $

    PROMPT_DIRTRIM=3 # Number of directories shown
}

PROMPT_COMMAND=prompt_setup

set -o histexpand  # Enable expansion with !!
set -o braceexpand # Enable brace expansion
set -o emacs       # Use emacs style input

shopt -s cdspell                                           # Autocorrect cd typos
shopt -s cdable_vars                                       # Allow cd with variables
shopt -s checkwinsize                                      # Update screen size
shopt -s cmdhist                                           # Save multi-line commands as one
shopt -s extglob                                           # Extended globbing
shopt -s histappend                                        # Append history entries
shopt -s histreedit                                        # Put failed history searches in prompt
shopt -s histverify                                        # Put history search in prompt
shopt -s nocaseglob                                        # Case-insensitive globbing
shopt -s no_empty_cmd_completion                           # Don't show autocompletion for empty prompt
[ "${BASH_VERSINFO:-0}" -ge 4 ] && shopt -s autocd         # If command is name of directory, cd into it
[ "${BASH_VERSINFO:-0}" -ge 5 ] && shopt -s progcomp_alias # If alias exists, tries autocompletion for command

bind Space:magic-space                 # Autoexpand history after space
bind '"\e[A": history-search-backward' # Incremental history search with arrows
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'
bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set mark-symlinked-directories on"
bind "set show-all-if-ambiguous on"

HISTFILE="$HOME/.history"                       # History file
HISTCONTROL=erasedups:ignoreboth                # Ignore and erase duplicates, trim leading whitespaces
HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear" # Ignore commands
HISTFILESIZE=50000                              # Size of history file
HISTSIZE=10000                                  # Size of current history buffer

if command -v nvim &>/dev/null; then # Default editor
    export EDITOR='nvim'
elif command -v vim &>/dev/null; then
    export EDITOR='vim'
else
    export EDITOR='vi'
fi
