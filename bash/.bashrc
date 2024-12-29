#
# .bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Use vim keybindings
set -o vi

# Reset window size after each command
shopt -s checkwinsize

# History file
[[ ! -z "$XDG_CACHE_HOME" ]] && HISTFILE="$XDG_CACHE_HOME/history" || HISTFILE="$HOME/.history"

# Don't store duplicates or lines starting with space
HISTCONTROL=erasedups:ignoreboth

# Ignore one and two character commands, as well as some common commands
HISTIGNORE="?:??:clr:cls:exit:quit:history"

# History file size
HISTFILESIZE=50000

# History buffer size
HISTSIZE=10000

# Append to history every time the prompt is redrawn
PROMPT_COMMAND="history -a"

# Append to history file instead of overwriting
shopt -s histappend

# Put failed history substitution back on prompt
shopt -s histreedit

# Don't execute history substitution immediately
shopt -s histverify

# Correct spelling errors in cd
shopt -s cdspell

# Let ** search all directories recursively
shopt -s globstar

# Case insensitive globbing
shopt -s nocaseglob

# Don't complete empty prompt
shopt -s no_empty_cmd_completion

# Automatically cd into directories
[[ "${BASH_VERSINFO[0]}" -ge 4 ]] && shopt -s autocd

# Allow programmable completion of aliases
[[ "${BASH_VERSINFO[0]}" -ge 5 ]] && shopt -s progcomp_alias

[[ -f "$XDG_CONFIG_HOME/prompts/prompt.bash" ]] && . "$XDG_CONFIG_HOME/prompts/prompt.bash"

for alias in "$XDG_CONFIG_HOME/aliases/"*; do
  [[ -f "$alias" ]] && . "$alias"
done

[[ -f "$XDG_CONFIG_HOME/dircolors/dircolors" ]] && eval "$(dircolors $XDG_CONFIG_HOME/dircolors/dircolors)"

[[ -f "/usr/share/nvm/init-nvm.sh" ]] && . "/usr/share/nvm/init-nvm.sh"

:
