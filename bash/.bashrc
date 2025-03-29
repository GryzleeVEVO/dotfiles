#
# .bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Use vim keybindings. Mapping is configured by readline.
set -o vi

# We don't need tty flow control (Ctrl-S/Ctrl-Q)
stty -ixon -ixoff

# Update LINES and COLUMNS after each command
shopt -s checkwinsize

# History file
[[ -n "$XDG_CACHE_HOME" ]] &&
  HISTFILE="$XDG_CACHE_HOME/history" ||
  HISTFILE="$HOME/.history"

# History file size
HISTFILESIZE=50000

# History buffer size
HISTSIZE=10000

# Ignore 1-3 character commands, as well as some common commands
HISTIGNORE="?:??:???:clear:exit:quit:history"

# Don't store duplicates or lines starting with space
HISTCONTROL=erasedups:ignoreboth

# Append to history every time the prompt is redrawn
PROMPT_COMMAND="history -a"

# Append to history file instead of overwriting
shopt -s histappend

# Put failed history substitution back in prompt
shopt -s histreedit

# Don't execute history substitution immediately
shopt -s histverify

# Correct spelling errors in cd
shopt -s cdspell

# Let ** search all directories recursively
shopt -s globstar

# Case insensitive globbing
shopt -s nocaseglob

# Don't show completions for an empty prompt
shopt -s no_empty_cmd_completion

# If command is directory, cd into it
[[ "${BASH_VERSINFO[0]}" -ge 4 ]] && shopt -s autocd

# Allow programmable completion of aliases
[[ "${BASH_VERSINFO[0]}" -ge 5 ]] && shopt -s progcomp_alias

[[ -f "$XDG_CONFIG_HOME/prompts/prompt.bash" ]] &&
  . "$XDG_CONFIG_HOME/prompts/prompt.bash"

for alias in "$XDG_CONFIG_HOME/aliases/"*; do
  [[ -f "$alias" ]] && . "$alias"
done

[[ -f "$XDG_CONFIG_HOME/dircolors/dircolors" ]] &&
  eval "$(dircolors "$XDG_CONFIG_HOME"/dircolors/dircolors)"

# [[ -f "/usr/share/nvm/init-nvm.sh" ]] &&
#   . "/usr/share/nvm/init-nvm.sh"

# fnm
FNM_PATH="/home/gryzlee/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

# Just to have #? set to 0
:

